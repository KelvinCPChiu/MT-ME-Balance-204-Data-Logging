%%
%the governing equation should change evcs if changed this part
%%
function dy = SI_equ(t,y,para) 
dy = zeros(size(y));
dy(2)=-para.Gamma*y(2)-sin(y(1))-... %Equation 2
    para.lambda*(y(3)+y(1))+...
    para.Lambda_s*para.I_in*(para.I_slope*t+1)+...
    (1-para.Lambda_p)*para.I_b;
dy(4)=-para.Gamma*y(4)-sin(y(3))+... %Equation 3
    (-para.lambda*(y(3)+y(1))+...
    para.Lambda_s*para.I_in*(para.I_slope*t+1)-...
    para.Lambda_p*para.I_b)/para.eta;
dy([1 3])=y([2 4]);

end