function [apath,bpath,fpath] = getpath_gray(num,a)
%UNTITLED2 此处提供此函数的摘要
%   num表示不同的文件夹，a表示文件夹中第a个图片
%   此处提供详细说明
if num==1
    apath=strcat('dataset/gray/Alzheimer disease/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/Alzheimer disease/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/Alzheimer disease/gray_',num2str(a),'.png');
end

if num==2
    apath=strcat('dataset/gray/glioma/MRIandPET/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/glioma/MRIandPET/gray_PET',num2str(a),'.png');
    fpath=strcat('Results/glioma/MRIandPET/gray_',num2str(a),'.png');
end

if num==3
    apath=strcat('dataset/gray/glioma/MRIandSPECT/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/glioma/MRIandSPECT/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/glioma/MRIandSPECT/gray_',num2str(a),'.png');
end

if num==4
    apath=strcat('dataset/gray/hypertensive encephalopathy/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/hypertensive encephalopathy/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/hypertensive encephalopathy/gray_',num2str(a),'.png');
end

if num==5
    apath=strcat('dataset/gray/Metastatic bronchogenic carcinoma/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/Metastatic bronchogenic carcinoma/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/Metastatic bronchogenic carcinoma/gray_',num2str(a),'.png');
end

if num==6
    apath=strcat('dataset/gray/normal aging/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/normal aging/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/normal aging/gray_',num2str(a),'.png');
end
if num==7
    apath=strcat('dataset/gray/motor neuron/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/gray/motor neuron/gray_SPECT',num2str(a),'.png');
    fpath=strcat('Results/motor neuron/gray_',num2str(a),'.png');
end

if num==8
    if  a<10
    apath=strcat('dataset/gray/CTandMR-T2/CT_0',num2str(a),'.tiff');
    bpath=strcat('dataset/gray/CTandMR-T2/MR-T2_0',num2str(a),'.tiff');
    end
    if a==10
    apath=strcat('dataset/gray/CTandMR-T2/CT_',num2str(a),'.tiff');
    bpath=strcat('dataset/gray/CTandMR-T2/MR-T2_',num2str(a),'.tiff');
    end
    fpath=strcat('Results/CTandMR-T2/gray_',num2str(a),'.png');
end

if num==9
    if  a<10
    apath=strcat('dataset/gray/MR-T1andMR-T2/MR-T1_0',num2str(a),'.tiff');
    bpath=strcat('dataset/gray/MR-T1andMR-T2/MR-T2_0',num2str(a),'.tiff');
    end
    if a>=10
    apath=strcat('dataset/gray/CTandMR-T2/CT_',num2str(a),'.tiff');
    bpath=strcat('dataset/gray/CTandMR-T2/MR-T2_',num2str(a),'.tiff');
    end
    fpath=strcat('Results/MR-T1andMR-T2/gray_',num2str(a),'.png');
end
end