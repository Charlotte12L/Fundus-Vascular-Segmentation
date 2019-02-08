function MFimg=GetMF(orinimg)
greenimg=orinimg(:,:,2);
greenimg=double(greenimg);
greenimg=greenimg/max(greenimg(:));
height=size(greenimg,1);
width=size(greenimg,2);
maskimg=greenimg;
maskimg(find(maskimg<0.07))=0;
maskimg(find(maskimg>0.07))=1;
greenimg(find(greenimg<0.07))=max(greenimg(:))/2;
B=ones(15);
maskimg=imerode(maskimg,B);%ͼ��A1���ṹԪ��B����


patchsize=31
smoothfilter=ones(patchsize);
smoothfilter=smoothfilter./patchsize^2;
background=conv2(greenimg,smoothfilter,'same');
normimg=greenimg-background;
normimg=normimg.*maskimg;

%����Ϊ��ʼ��
normimg=normimg.*255;


a=0.02
sigma=2;
yLength=10;
direction_number=20;
MF = MatchFilter(normimg, sigma, yLength,direction_number);
MF = normalize(double(MF));%��һ����0��1֮��

MFimg=MF;
level = graythresh(MFimg)-a;%ostu������ֵ�ָ�
MFimg(find(MFimg>level))=1;
MFimg(find(MFimg<=level))=0;
MFimg=bwareaopen(MFimg,100);
