clear
clc
load('..\data\SMNet_s_3239.txt') %% existing relationships between target site and PTM
load ('..\data\SMNet_s_sequence_similarity_3239.txt') %% local sequence kernel similarity 
deci_svm_s_3239_kernel = cell(11,1);
interaction = SMNet_s_3239;
sim_seq = SMNet_s_sequence_similarity_3239;

 for i = 1:11
     i
     weight = 0.1;
     for j = 1:length(weight)
         label=interaction(:,i);
         cmd=[' -w1 ',num2str(sum(label==0)/sum(label==1)),' -w0 ',num2str(1),' -t ',num2str(4),' -b ',num2str(1)];
         [deci,predict_label]=get_cv_deci(label,interaction,sim_seq,cmd,10,i,weight(j));
         deci_svm_s_3239_kernel{i,j}=deci;
         
         [auc1,sn,sp] = roc(deci(:,1),label,'r');
         AUC_weight_s_kernel(i,j) = auc1;
         
     end
 end

