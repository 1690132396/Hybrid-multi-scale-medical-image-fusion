function [apath,bpath,fpath] = getpath_color(num,a)
%UNTITLED2 此处提供此函数的摘要
%   num表示不同的文件夹，a表示文件夹中第a个图片
%   此处提供详细说明
if num==1
    apath=strcat('dataset/rgb/Alzheimer disease/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/Alzheimer disease/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/Alzheimer disease/rgb_',num2str(a),'.png');
end

if num==2
    apath=strcat('dataset/rgb/glioma/MRIandPET/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/glioma/MRIandPET/rgb_PET',num2str(a),'.png');
    fpath=strcat('Results/glioma/MRIandPET/rgb_',num2str(a),'.png');
end

if num==3
    apath=strcat('dataset/rgb/glioma/MRIandSPECT/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/glioma/MRIandSPECT/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/glioma/MRIandSPECT/rgb_',num2str(a),'.png');
end

if num==4
    apath=strcat('dataset/rgb/hypertensive encephalopathy/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/hypertensive encephalopathy/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/hypertensive encephalopathy/rgb_',num2str(a),'.png');
end

if num==5
    apath=strcat('dataset/rgb/Metastatic bronchogenic carcinoma/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/Metastatic bronchogenic carcinoma/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/Metastatic bronchogenic carcinoma/rgb_',num2str(a),'.png');
end

if num==6
    apath=strcat('dataset/rgb/normal aging/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/normal aging/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/normal aging/rgb_',num2str(a),'.png');
end
if num==7
    apath=strcat('dataset/rgb/motor neuron/gray_MRI',num2str(a),'.png');
    bpath=strcat('dataset/rgb/motor neuron/rgb_SPECT',num2str(a),'.png');
    fpath=strcat('Results/motor neuron/rgb_',num2str(a),'.png');
end

end