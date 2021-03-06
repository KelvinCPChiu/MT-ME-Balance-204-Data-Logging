function [para,T_all,UP_all,intervs,TE,YE] = dynaE(p4,ini)

para = SI_para(p4);
options = odeset('RelTol',1e-9,'Events',@(t,y) evcs(t,y,para));
if size(ini,1) == 0
    ini = [zeros(1,para.N_total),ones(1,para.N_total)];
end
[T_all,UP_all,TE,YE] = ode45(@(t,y) SI_equ(t,y,para),[0 para.T_total],ini,options);

seg = 20;
if size(YE,1)<(seg+1)
    intervs = [];
else 
    rE = FR(para,YE);
    cali = sort(randperm(seg-1,5));
    dsr = zeros(1,length(TE)-seg);
    muban = rE(:,cali+length(TE)-seg);
    mx = max(max(muban));
    for i = seg : length(TE)-1
        now_test = rE(:,cali+i-seg);
        dsr(i-seg+1) = max(max(abs(now_test-muban)))/mx;
    end
    t_dsr = TE(seg:(length(TE)-1));
%     figure();plot(t_dsr,log(dsr),'x');
    t_sp = t_dsr(log(dsr)<-14);
    intervs = diff(t_sp);
%     dsu = sum(abs(bsxfun(@minus,YE(1:(size(YE,1)-1),:),YE(size(YE,1),:))),2);
%     ix = find(log(dsu)<-3);
%     if numel(ix)>2
%         intervs = diff(TE(ix));
%         intervs = intervs(abs(intervs-intervs(numel(intervs)))<0.01);
%     else
%         intervs = [];
%     end
end
end