function [t,process,process2,Data,Time_data,load2] = chuku(Data,chrom1,Distance,DO2,Time_data,load2,date,time,z,G,amount)%,load2,Data,Time_data
t1=0;
t2=0;
t3=0;
local=0;
process=time;
process2=[date,time];
for m=1:length(amount)
    col=find(Data(7,:)==z(m));%l��r����Ҫ���ĵ�Ʒ���,z�ǵ�Ʒ����zhonglei  7������
    d=zeros(1,length(col));
    for i=1:length(col)
        d(i)=Distance(chrom1==local,chrom1==Data(6,col(i)));  %6�Ǳ��
    end
    t=Data(3,col);
    while amount(m)>0
          if (~isempty(col))&&(sum(Data(4,col))>=amount(m)) %4��������5�ǲ������ֵ
              colt=find(t==min(t));
              coll=find(d==min(d(colt)));
              if load2(col(coll(1)))==0
                 Time_data((load2(col(coll(1)))+1)*1,col(coll(1)))=0;%�ȴ�ʱ��
                 t3=t3+Time_data(1,col(coll(1)));%�ȴ���ʱ��
                 t1=t1+d(coll(1))/5000;%·����ʱ��
                 Time_data((load2(col(coll(1)))+1)*2,col(coll(1)))=time+t1+t2+t3;%����ʱ��
                 t2=t2+min(amount(m),Data(4,col(coll(1))))*G(m)/200;%ж����ʱ��
                 Time_data((load2(col(coll(1)))+1)*3,col(coll(1)))=time+t1+t2+t3;%�뿪�ò�λ��ʱ��
                 load2(col(coll(1)))=load2(col(coll(1)))+1;
              else 
                 t1=t1+d(coll(1))/5000;
                 if Time_data(load2(col(coll(1)))*3,col(coll(1)))>time+t1+t2+t3
                     Time_data(load2(col(coll(1)))*3+1,col(coll(1)))=Time_data(load2(col(coll(1)))*3,col(coll(1)))-(time+t1+t2+t3);
       
                     t3=t3+Time_data(load2(col(coll(1)))*3+1,col(coll(1)));%�ȴ���ʱ��
                     Time_data(load2(col(coll(1)))*3+2,col(coll(1)))=time+t1+t2+t3;
                     t2=t2+min(amount(m),Data(4,col(coll(1))))*G(m)/200;
                     Time_data(load2(col(coll(1)))*3+3,col(coll(1)))=time+t1+t2+t3;%�뿪�ò�λ��ʱ��
                     load2(col(coll(1)))=load2(col(coll(1)))+1;
                 else
                     Time_data(load2(col(coll(1)))*3+1,col(coll(1)))=0;%t3�ǵȴ�ʱ��
                     t3=t3+Time_data(load2(col(coll(1)))*3+1,col(coll(1)));%�ȴ���ʱ��
                     Time_data(load2(col(coll(1)))*3+2,col(coll(1)))=time+t1+t2+t3;%����ʱ��
                     t2=t2+min(amount(m),Data(4,col(coll(1))))*G(m)/200;
                     Time_data(load2(col(coll(1)))*3+3,col(coll(1)))=time+t1+t2+t3;%�뿪�ò�λ��ʱ��
                     load2(col(coll(1)))=load2(col(coll(1)))+1;
                 end
              end 
              process=[process,col(coll(1)),Time_data(load2(col(coll(1)))*3-2,col(coll(1))),Time_data(load2(col(coll(1)))*3-1,col(coll(1))),Time_data(load2(col(coll(1)))*3,col(coll(1)))];
              process2=[process2,col(coll(1)),Time_data(load2(col(coll(1)))*3-1,col(coll(1))),z(m),min(amount(m),Data(4,col(coll(1)))),Time_data(load2(col(coll(1)))*3,col(coll(1)))];

              amount(m)=amount(m)-min(amount(m),Data(4,col(coll(1))));%��������
              Data(4,col(coll(1)))=Data(4,col(coll(1)))-min(amount(m),Data(4,col(coll(1))));   %���²���
              %Data(3,col(coll(1)))=date;%���ʱ�����
              local=Data(6,col(coll(1)));%(1���µص�
              col(coll(1))=[];
              t(coll(1))=[];
              d=zeros(1,length(col));
              for i=1:length(col)
                  d(i)=Distance(chrom1==local,chrom1==Data(6,col(i)));  %6�Ǳ��
              end
          else
              break
          end
    end
end
time_end=time+t1+t2+t3+DO2(chrom1==local)/5000;
process2=[process2,time_end];
t=time_end-time;

              
              
              
              
        