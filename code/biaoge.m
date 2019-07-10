%生成表格的代码
cangwei=xlsread('C:\Users\a\Desktop\历史数据摆放.xlsx',1,'A2:H96');
leng=[ones(1,45)*9,ones(1,50)*12];
Leng=cangwei(:,2)';
R=cangwei(:,3)';
T=cangwei(:,4)';
Amount=cangwei(:,6)';
maxamount=cangwei(:,5)';
Number=cangwei(:,1)';
zhonglei=cangwei(:,8)';
Data=[Leng;R;T;Amount;maxamount;Number;zhonglei];%Leng是仓位单品长度，R是仓位单品直径，T是最早入库时间，Amount是目前仓所摆放的件数，maxamount是能摆放的最大件数,Number是仓位编号,local是目前所在位置
process1=zeros(10,100);
process3=zeros(1000,100);
process5=zeros(85,100);
process6=zeros(1000,100);
%load2=zeros(1,100);
%A=cangweizhi2(leng,aaa);
%[Distance,DO2,chrom1]=juli2(A,leng);
zz1=1;
zz2=1;

rukudata=xlsread('C:\Users\a\Desktop\10月1-22入库.xlsx',5);
x = xlsread('C:\Users\a\Desktop\10月1-22 - 出库.xlsx',1);
x2=xlsread('C:\Users\a\Desktop\10月1-22 - 出库.xlsx',2);
x4=xlsread('C:\Users\a\Desktop\10月1-22 - 出库.xlsx',5);
x3=xlsread('C:\Users\a\Desktop\70种LRG.xlsx',1,'C3:F72');
%A=cangweizhi2(leng,aaa);
cangwei1=xlsread('C:\Users\a\Desktop\仓位.xlsx',1,'A1:L10');
A=zeros(10,12);
for i=1:10
    A(i,:)=cangwei1(i,:);
end
[Distance,DO2,chrom1]=juli2(A,leng);
for day=1:22
load2=zeros(1,100);
Time_data=zeros(20*3,95);
y1=rukudata(rukudata(:,1)==day,:);
y2=x(x4(:,1)==day,:);
y3=x2(x4(:,1)==day,:);
caramount=length(y1(:,1))+length(y2(:,1));
aa=exprnd(5,1,caramount+30);
%bb=aa(aa<=12);
cc=sort(aa);
cc=cc(1:caramount);
cc(cc>12)=12;
date=ones(1,length(y1(:,1)))*day;
        time=cc(1:length(y1(:,1)));
       
        
for p=1:length(y1(:,1))
    date=day;
    l=x3(x3(:,1)==y1(p,2),1);
    r=x3(x3(:,1)==y1(p,2),2);
    z=y1(p,2);
    G=x3(x3(:,1)==y1(p,2),4);
    amount=y1(p,3);
            [t,process,process2,Data,Time_data,load2]=ruku(Data,chrom1,Distance,DO2,Time_data,load2,date,time(p),l,r,z,G,amount);%,Data,Time_data,load2
            i=1:length(process);
            process1(p,i)=process(i);
            j=1:length(process2);
            process3(zz1,j)=process2(j);
            tt1(p)=t;
            zz1=zz1+1;
end
time2=cc(length(y1(:,1))+1:caramount);
      for q=1:length(y2(:,1))
    %chukudata1=chukudata(n,:);
    %chukudata1(chukudata1(1,:)==0)=[];
    %l=chukudata1(1:(length(chukudata1)-1)/5);
    %r=chukudata1((length(chukudata1)-1)/5+1:(length(chukudata1)-1)/5+5);
    %z=chukudata1((length(chukudata1)-1)/5+6:(length(chukudata1)-1)/5+10);
    %G=chukudata1((length(chukudata1)-1)/5+11:(length(chukudata1)-1)/5+15);
    %amount=chukudata1((length(chukudata1)-1)/5+16:(length(chukudata1)-1)/5+20);
    %time=chukudata1(length(chukudata1));
    z=y2(q,:);
    z(z==0)=[];
    amount=y3(q,:);
    amount(amount==0)=[];
    time=time2(q);
    date=day;
    for h=1:length(z)
        G(h)=x3(x3(:,1)==z(h),4);
    end
    [t,process,process4,Data,Time_data,load2]=chuku(Data,chrom1,Distance,DO2,Time_data,load2,date,time,z,G,amount);%,Data,Time_data,load2
    i=1:length(process);
    process5(q,i)=process(i);
    j=1:length(process4);
    process6(zz2,j)=process4(j);
    zz2=zz2+1;
    tt2(q)=t;
    liudongcang=Data(4,69:95);
    a=find(liudongcang==0);
    Data(1,a+68)=0;
    Data(2,a+68)=0;
    Data(7,a+68)=0;  
      end    
end
xlswrite('C:\Users\a\Desktop\问题的结果.xlsx',process3,1);
xlswrite('C:\Users\a\Desktop\问题的结果.xlsx',process6,2);