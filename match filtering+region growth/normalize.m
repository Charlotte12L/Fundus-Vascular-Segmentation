function X = normalize(I)
%�ú������ڽ�ͼƬ��һ����0~1
minValue = min(min(I));
maxValue = max(max(I));
X = (I - minValue) /(maxValue - minValue);