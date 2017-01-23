function sim_net = sim_network(new_interaction)

%% Gauss interaction profile kernel similarity
    nd = size(new_interaction,1);
    sim_net = zeros(nd,nd);
%     for i=1:nd
%         sd(i)=norm(new_interaction(i,:))^2;
%     end
%     gamadd=1.0;
%     gamad=nd/sum(sd')*gamadd;
    gamad = 0.001;
    for i=1:nd
        for j=1:nd
            sim_net(i,j)=exp(-gamad*(norm(new_interaction(i,:)-new_interaction(j,:)))^2);
        end
    end 

end