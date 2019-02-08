%�ó�������ͳ��20��ͼƬ�����жȡ��������׼ȷ��
Se=zeros(20,1);%���ж�
Sp=zeros(20,1);%�����
Acc=zeros(20,1);%׼ȷ��

for k=1:20
if k<10
impath=['.\drive\0',num2str(k),'_test.tif'];
labelpath=['.\ground truth\0',num2str(k),'_manual1.tif'];
%resultpath=['.\result\0',num2str(k),'_result.tif']; ��������ָ���
end
if k>=10
impath=['.\drive\',num2str(k),'_test.tif'];
labelpath=['.\ground truth\',num2str(k),'_manual1.tif'];
%resultpath=['.\result\',num2str(k),'_result.tif']; ��������ָ���
end
orinimg=imread(impath);
label=imread(labelpath);
height=size(label,1);
width=size(label,2);

label=double(label)/255;
label(find(label>0.3))=1;
label(find(label~=1))=0;


tophatimg=tophat(orinimg);
climg=centerline(orinimg);
[xf,yf]=find(climg==1);
tophatimg(find(tophatimg>0.3))=1;
tophatimg(find(tophatimg~=1))=0;
tophatimg=bwareaopen(tophatimg,20,8);
resultimg=region(tophatimg,[xf,yf],1,1.2);
resultimg(find(resultimg>0.1))=1;
resultimg(find(resultimg~=1))=0;
resultimg=bwareaopen(resultimg,100,8);
%imwrite(resultimg,resultpath);��������ָ���


TP=0;
TN=0;
P=length(find(label==1));%TP+FN
N=length(find(label==0));
for i=1:height
    for j=1:width
        if label(i,j)==1 & resultimg(i,j)==1
            TP=TP+1;
        end
        if label(i,j)==0 & resultimg(i,j)==0
            TN=TN+1;
        end
    end
end
Se(k)=TP/P;
Sp(k)=TN/N;
Acc(k)=(TP+TN)/(height*width);
end


