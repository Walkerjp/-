%�Ŵ��㷨���TSP����(Ϊѡ�����������ƺ����)
%���룺
%NIND    Ϊ��Ⱥ����
%MAXGEN  Ϊֹͣ�������Ŵ�����MAXGEN��ʱ����ֹͣ,MAXGEN�ľ���ȡֵ������Ĺ�ģ�ͺķѵ�ʱ�����
%m       Ϊ��ֵ��̭����ָ��,���ȡΪ1,2,3,4,����̫��
%Pc      �������
%Pm      �������
%�����
%R       Ϊ���·��
%Rlength Ϊ·������
clear
clc
close all
%% ��������
N=95;    %��λ����
%% �Ŵ�����
NIND=100;       %��Ⱥ��С
MAXGEN=200;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,N);
%% ����������·��ͼ
%DrawPath(Chrom(1,:),X)
%pause(0.0001)
%% ���������·�����ܾ���
%disp('��ʼ��Ⱥ�е�һ�����ֵ:')
%OutputPath(Chrom(1,:));
%Rlength=PathLength(D,Chrom(1,:));
%disp(['�ܾ��룺',num2str(Rlength)]);
%disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
cangwei=xlsread('C:\Users\a\Desktop\��ʷ���ݰڷ�.xlsx',1,'A2:H96');
leng=[ones(1,45)*9,ones(1,50)*12];
Leng=cangwei(:,2)';
R=cangwei(:,3)';
T=cangwei(:,4)';
Amount=cangwei(:,6)';
maxamount=cangwei(:,5)';
Number=cangwei(:,1)';
zhonglei=cangwei(:,8)';
x = xlsread('C:\Users\a\Desktop\10�½��(1).xlsx',1,'C2:J86');
x2=xlsread('C:\Users\a\Desktop\10�½��(1).xlsx',1,'L2:S86');
x3=xlsread('C:\Users\a\Desktop\70��LRG.xlsx',1,'C3:F72');
%% �Ż�
gen=0;
figure;
hold on;box on
xlim([0,MAXGEN])
title('�Ż�����')
xlabel('����')
ylabel('����ֵ')
ObjV=PathLength(x,x2,x3,Chrom,leng,Leng,R,T,Amount,maxamount,Number,zhonglei);  %����·������
preObjV=min(ObjV);
ppreObjV=[];FANGAN=[];%��¼��õķ���


while gen<MAXGEN+1
    %% ������Ӧ��
    ObjV=PathLength(x,x2,x3,Chrom,leng,Leng,R,T,Amount,maxamount,Number,zhonglei);  %����·������
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    line([gen-1,gen],[preObjV,min(ObjV)]);%pause(0.0001)
    preObjV=min(ObjV);
    FitnV=fitness(ObjV);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fangan=Chrom(ObjV==preObjV,:);fangan=fangan(1,:);
    ppreObjV=[ppreObjV;preObjV];FANGAN=[FANGAN;fangan];
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=Reverse(x,x2,x3,SelCh,leng,Leng,R,T,Amount,maxamount,Number,zhonglei);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% ���µ�������
    gen=gen+1 ;
end
%% �������Ž��·��ͼ
ObjV=PathLength(x,x2,x3,Chrom,leng,Leng,R,T,Amount,maxamount,Number,zhonglei);  %����·������
[minObjV,minInd]=min(ObjV);
%DrawPath(Chrom(minInd(1),:),X)
%% ������Ž��·�����ܾ���
disp('���Ž�:')
p=OutputPath(Chrom(minInd(1),:));
best=Chrom(minInd(1),:);
AA=cangweizhi2(leng,best);
disp(['��ʱ�䣺',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
