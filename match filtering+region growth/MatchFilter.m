function [image2,MatchFilterKernel] = MatchFilter(image1,sigma,yLength, direction_number)
%�ú������ڶ�ͼ�����ƥ���˲�
    
[a, b] = size(image1);
image1 = double(image1);
MatchFilter_image=zeros(a,b,direction_number);
for i = 1:direction_number %�ȷ�180�㣬�˲�
    MatchFilterKernel = MatchFilterAndGaussDerKernel(sigma,yLength, pi/direction_number*(i-1),0);
    MatchFilter_image(:,:,i) = conv2(image1,MatchFilterKernel,'same');
end
image2 = max(MatchFilter_image,[],3);%ѡȡ����
%image2 = uint8(image2);

end

    