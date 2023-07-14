function [ca,cb] = Relevancy(img1,img2,img3,img4)
%%%%填充0
addpath(genpath('imageFusionMetrics-master'));
AImg = padarray(img1,[7,7 ],'symmetric','both');%visible
BImg = padarray(img2,[7,7],'symmetric','both');%infrared
CImg = padarray(img3,[7,7],'symmetric','both');%pre-fusion
DImg = padarray(img4,[7,7],'symmetric','both');
[M,N]= size(AImg);

%15 * 15 的图像块。

i = 1:M-15+1;
j = 1:N-15+1;
[I,J] = meshgrid(i,j);
parfor i = 1:numel(I)              %9
        %  Local relevancy score
        A1 = AImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        B1 = BImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        C1 = CImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        D1 = DImg( (I(i)-1)*1+1:(I(i)-1)*1+15, (J(i)-1)*1+1:(J(i)-1)*1+15 );
        Cascore(i) = metricPeilla(A1,B1,C1,2);
        Cbscore(i) = metricPeilla(A1,B1,D1,2);
%%相位
%         A_phase=phasecong3(A1);
%         B_phase=phasecong3(B1);
%         C_phase=phasecong3(C1);
%         D_phase=phasecong3(D1);       
%         Cascore(i) = metricPeilla(A_phase,B_phase,C_phase,2);
%         Cbscore(i) = metricPeilla(A_phase,B_phase,D_phase,2);
%%均方根误差
%         a1=C1-A1;
%         b1=A1.*C1;
%         a2=C1-B1;
%         b2=B1.*C1;
%         Cascore(i) = 0.5*sum(a1(:).*a1(:))/numel(A1)+0.5*sum(a2(:).*a2(:))/numel(B1);
%         c1=D1-A1;
%         d1=A1.*D1;
%         c2=D1-B1;
%         d2=B1.*D1;
%         Cbscore(i) = 0.5*sum(c1(:).*c1(:))/numel(A1)+0.5*sum(c2(:).*c2(:))/numel(B1);

end

cbscore = reshape(Cbscore,length(j),length(i));
cb = transpose(cbscore);
cascore = reshape(Cascore,length(j),length(i));
ca = transpose(cascore);

% Max1=max(cb);
% Min1=min(cb);
% Max2=max(ca);
% Min2=min(ca);
% 
% for i=1:M-14
%     for j=1:N-14
%         cb(i,j)=(cb(i,j)-Min1)/(Max1-Min1);
%         ca(i,j)=(ca(i,j)-Min2)/(Max2-Min2);
%     end
% end


end