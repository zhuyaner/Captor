function [iindex1,iindex2]=AAindex()
filename='AAIDEX.xlsx';
X= xlsread(filename);
IndexMatrix=zeros(553,21);

for i=1:553
    M1=X(i,:);
    XX= mapminmax(M1,0,1);
    IndexMatrix(i,:) =XX;
end
AA='ARNDCEQGHILKMFPSTWYVX';

[hp,positive]=fastaread('P.txt');%trainpositive.txt
Np=length(hp);%number of positive samples
M=length(positive{1,1});
x=(M+1)/2;

for i=1:Np 
    positive{1,i}(x)='';
end
[hn,negative]=fastaread('N.txt');
Nn=length(hn);
for i=1:Nn
    negative{1,i}(x)='';
end
M=length(positive{1,1});
iindex1=zeros(Np,553);
iindex2=zeros(Nn,553);
for m=1:553
    for i=1:Np
        for j=1:M
            t=positive{1,i}(j);
             if t=='U'
                 continue  %在正样本序列中包含‘U’
             end
            k=strfind(AA,t);
            iindex1(i,m)=iindex1(i,m)+IndexMatrix(m,k);
        end
    end
end
iindex1=iindex1/M;

for m=1:553
    for i=1:Nn
        for j=1:M
            t=negative{1,i}(j);
             if t=='U'
                 continue  %在负样本序列中包含‘U’
             end
            k=strfind(AA,t); 
            iindex2(i,m)=iindex2(i,m)+IndexMatrix(m,k);
        end
    end
end
iindex2=iindex2/M;
