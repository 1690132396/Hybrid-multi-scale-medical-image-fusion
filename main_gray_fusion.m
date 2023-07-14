clear
clc
close all;
addpath ('./NSCT_TOOLBOX/nsct');
Para.iterTimes=200;
Para.link_arrange=7;
Para.alpha_L=0.02;
Para.alpha_Theta=3;
Para.beta=3;
Para.vL=1;
Para.vTheta=20;
ParaSet=100;
t=3;
%%%%%%获取文件路径，j代表不同文件夹，i表示不同的图片,用不同图像时候只需要注释这里更换一下路径
for j=1:9 
num=get_ImageNum(j);
for i=1:num
[imagepath1,imagepath2,fusepath]=getpath_gray(j,i);

Y1=imread(imagepath1);
Y2=imread(imagepath2);
f1=double(Y1);
f2=double(Y2);

[M,N] = size(f1);
Lrr_img=cell(1,2);
Sal_img=cell(1,2);
C=cell(1,2);
C{1}=f1;
C{2}=f2;
disp('Process in  MDLatLRR...')
disp(i)
disp(j)
parfor z = 1:2
     [Lrr_img{z},Sal_img{z}] = MDLatLRR(C{z});
end

a=Sal_img{1};
b=Sal_img{2};
for z = 1:4
    X1_lrr(:,:,z) = a{z};
    X2_lrr(:,:,z) = b{z};
end
%%%%%%%基于PCNN的显著层融合
for z = 1:4
    X_2(:,:,z) = fusion_NSST_MSMG_PCNN(X1_lrr(:,:,z),X2_lrr(:,:,z),Para,t);
end
Lrr1=Lrr_img{1};
Lrr2=Lrr_img{2};
Lrr =zeros(M,N);

%%%%%%%%%%%%%%
y1=nsctdec(Lrr1/256,[1,1,1,1],'pkva','9-7');
y2=nsctdec(Lrr2/256,[1,1,1,1],'pkva','9-7');
n=length(y1);
y{1}=Low_fusion(y1{1},y2{1});
p=0.2;
e=1+p;
w=1-p;
y_enhance{1}=y{1}*e;
y_weak{1}=y{1}*w;
%基于PCNN的高频层融合
for l=2:n
    if l<5
        for d=1:length(y1{l})
            y{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t);
            y_enhance{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t)*e;
            y_weak{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t)*w;
        end
    end
    if l>=5
        for d=1:length(y1{l})
            y{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t);
            y_enhance{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t)*e;
            y_weak{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t)*w;
        end
    end
end


imgf_enhance=nsscrec(y_enhance,'pkva','9-7')*256+X_2(:,:,1)*e+X_2(:,:,2)*e+X_2(:,:,3)*e+X_2(:,:,4)*e;
imgf_weaken=nsscrec(y_weak,'pkva','9-7')*256+X_2(:,:,1)*w+X_2(:,:,2)*w+X_2(:,:,3)*w+X_2(:,:,4)*w;
%利用局部结构相似度度量指标构建修正权重
[CAscore,CBscore] = Relevancy(f1, f2, imgf_enhance,imgf_weaken);
offset = CAscore-CBscore ;
Weight = 1 + offset;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y{1}=Low_fusion(y1{1},y2{1}).*Weight;
for l=2:n
    if l<5
        for d=1:length(y1{l})
            y{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t).*Weight;
        end
    end
    if l>=5
        for d=1:length(y1{l})
            y{l}{d}=fusion_NSST_MSMG_PCNN(y1{l}{d},y2{l}{d},Para,t).*Weight;
        end
    end
end

YY=nsscrec(y,'pkva','9-7')*256+X_2(:,:,1).*Weight+X_2(:,:,2).*Weight+X_2(:,:,3).*Weight+X_2(:,:,4).*Weight;
imwrite(uint8(YY),fusepath);
end
end  
