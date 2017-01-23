function [deci,predict_label] = get_cv_deci(label,interaction,sim_seq,param,nr_fold,column,weight)
deci = zeros(length(label),3);
K_fold_indx = CV_split_data(label,nr_fold);
for i=1:nr_fold % Cross training : folding
% for i=1
    i
    train_ind=K_fold_indx{i,2};
    test_ind=K_fold_indx{i,1};
    
    new_interaction=interaction;
    new_interaction(test_ind,column)=0; 
    
%     weight = 0.0; %%% 
    sim_net = sim_network(new_interaction);  %% network_similarity
    sim_total = weight * sim_seq +(1-weight) * sim_net;
    feature_train = sim_total(train_ind,:);
    train_f = feature_train(:,train_ind);
    feature_test = sim_total(test_ind,:);
    test_f = feature_test(:,train_ind);
    train_len = size(train_f,1);
    test_len = size(test_f,1);
    
    model = svmtrain(label(train_ind),[(1:train_len)', train_f],param);
    [predict_label, ~, prob_estimates] = svmpredict(label(test_ind),[(1:test_len)', test_f],model,'-b 1'); 
    if model.Label(1) == 1
        deci(test_ind,1) = prob_estimates(:,1);
    else
        deci(test_ind,1) = prob_estimates(:,2);
    end
    
%     parameter = [' -w1 ',num2str(sum(label==0)/sum(label==1)),' -w0 ',num2str(1),' -b ',num2str(1)];
%     feature = [seq_quad new_interaction];
%     model_2 = svmtrain(label(train_ind),feature(train_ind,:),parameter);
%     [predict_label, ~, prob_estimates_2] = svmpredict(label(test_ind),feature(test_ind,:),model_2,'-b 1');
%     if model_2.Label(1)==1
%         deci(test_ind,2) = prob_estimates_2(:,1);
%     else
%         deci(test_ind,2) = prob_estimates_2(:,2);
%     end
%     
%     model_3 = svmtrain(label(train_ind),seq_quad(train_ind,:),parameter);
%     [predict_label, ~, prob_estimates_3] = svmpredict(label(test_ind),seq_quad(test_ind,:),model_3,'-b 1');
%     if model_3.Label(1)==1
%         deci(test_ind,3) = prob_estimates_3(:,1);
%     else
%         deci(test_ind,3) = prob_estimates_3(:,2);
%     end

end

end