clear
clc
load('..\data\SMNet_y_1880.txt') %% existing relationships between target site and PTM
load ('..\data\SMNet_y_sequence_similarity_1880.txt') %% local sequence kernel similarity 
deci_svm_y_1880_kernel = cell(7,1);
interaction = SMNet_y_1880;
sim_seq = SMNet_y_sequence_similarity_1880;

 for i = 1:1
     i
     weight = 0.1;
     for j = 1:length(weight)
         label=interaction(:,i);
         cmd=[' -w1 ',num2str(sum(label==0)/sum(label==1)),' -w0 ',num2str(1),' -t ',num2str(4),' -b ',num2str(1)];
         [deci,predict_label]=get_cv_deci(label,interaction,sim_seq,cmd,10,i,weight(j));
         deci_svm_y_1880_kernel{i,j}=deci;
         
         [auc1,sn,sp] = roc(deci(:,1),label,'r');
         AUC_weight_s_kernel(i,j) = auc1;

     end
 end
