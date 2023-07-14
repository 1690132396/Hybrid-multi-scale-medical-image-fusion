clear
clc
close all;
%%%%%%%%%%%%%%%%%%%%加载相关文件和参数初始化
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
tic
%%%%%%获取文件路径，j代表不同文件夹，i表示不同的图片,用不同图像时候只需要注释这里更换一下路径
for j=1:7 
num=get_ImageNum(j);
for i=1:num
[imagepath1,imagepath2,fusepath]=getpath_color(j,i);

Y1=imread(imagepath1);
Y2=imread(imagepath2);
f1 = double(Y1)/255;
img2 = double(Y2)/255;

img2_YUV=ConvertRGBtoYUV(img2);    %   YUVtoRGB
f2=img2_YUV(:,:,1);


[M,N] = size(f1);
Lrr_img=cell(1,2);
Sal_img=cell(1,2);
C=cell(1,2);
C{1}=f1;
C{2}=f2;
parfor z = 1:2
    [Lrr_img{z},Sal_img{z}] = MDLatLRR(C{z});
end
disp('Process in  MDLatLRR...')
disp(i)
disp(j)
a=Sal_img{1};
b=Sal_img{2};
for z = 1:4
    X1_lrr(:,:,z) = a{z};
    X2_lrr(:,:,z) = b{z};
end
for z = 1:4
    X_2(:,:,z) = fusion_NSST_MSMG_PCNN(X1_lrr(:,:,z),X2_lrr(:,:,z),Para,t);% PCNN
end
Lrr1=Lrr_img{1};
Lrr2=Lrr_img{2};
Lrr =zeros(M,N);


y1=nsctdec(Lrr1,[1,1,1,1],'pkva','9-7');
y2=nsctdec(Lrr2,[1,1,1,1],'pkva','9-7');

n=length(y1);
y{1}=Low_fusion(y1{1},y2{1});
% 线性调整因子
p=0.1;
e=1+p;
w=1-p;
y_enhance{1}=y{1}*e;
y_weak{1}=y{1}*w;

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
toc;


imgfCSM3=nsscrec(y_enhance,'pkva','9-7')+X_2(:,:,1)*e+X_2(:,:,2)*e+X_2(:,:,3)*e+X_2(:,:,4)*e;
imgfCSM4=nsscrec(y_weak,'pkva','9-7')+X_2(:,:,1)*w+X_2(:,:,2)*w+X_2(:,:,3)*w+X_2(:,:,4)*w;
%利用局部结构相似度度量指标构建修正权重
[CAscore,CBscore] = Relevancy(f1, f2, imgfCSM3,imgfCSM4);
offset = CAscore-CBscore ;
Weight = 1 + offset;
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
YY=nsscrec(y,'pkva','9-7')+X_2(:,:,1).*Weight+X_2(:,:,2).*Weight+X_2(:,:,3).*Weight+X_2(:,:,4).*Weight;
imgf_YUV=zeros(M,N,3);
%颜色反变换YUV to RGB
imgf_YUV(:,:,1)=YY;
imgf_YUV(:,:,2)=img2_YUV(:,:,2);
imgf_YUV(:,:,3)=img2_YUV(:,:,3);

YY_f=ConvertYUVtoRGB(imgf_YUV);
imwrite(YY_f,fusepath);
end
end
toc