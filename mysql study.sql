
--ע�⣺(1)SQL��������еķ��Ŷ������ǰ�ǣ�Ӣ��״̬��
        (2)�����ִ�Сд

--�������ݿ�
create database bjglxt
create database a2

--���������ݿ�
sp_renamedb a1,a2

--ɾ�����ݿ�
drop database a1,a2

��Ĵ���

��(������)���洢����

1.����SQL Server����ƽ̨�������������
   ȷ����Ľṹ��
            (1)����(����)
            (2)��������
            (3)�Ƿ�Ϊnull
            (4)����Լ��(������)
            
2.����Transact-SQL����������

--����ѧ����student

create table student
( sno char(8) not null,
  sname char(8) ,
  ssex char(2) ,
  sage int,
  sbir datetime
)

--������һ��������Ϣ�����������˱�š�������
--�Ա𡢳������ڡ�ְλ�����ʺͱ�ע��Ϣ��

create table worker
( number char(8) not null,   --���˱��
  name char(8) not null,     --����
  sex char(2) ,              --�Ա�
  birthday datetime ,         --��������
  job_title varchar(10) ,     --ְλ
  salary money ,              --����
  memo ntext                   --��ע��Ϣ  
)

--����һ���ɼ���ѧ�ţ��γ̺ţ�ƽʱ�ɼ����ڿ��ɼ��������ɼ���ƽʱ�ɼ�*0.4+�ڿ��ɼ�*0.6��
create table chengjibiao
( sno char(8) not null,
  cno char(5) not null,
  pscj int,
  qkcj int,
  zpcj  as pscj*0.4+qkcj*0.6
)

CREATE TABLE autouser
( ��� int identity(1,1) NOT NULL,
  �û����� varchar(18),
  ��¼ʱ�� AS Getdate(),    --ϵͳ������Getdate():��ȡϵͳʱ��
  �û��� AS User_name()      --ϵͳ����
)



����Լ�� 
--Լ����SQL Server�ṩ���Զ��������ݿ������Ե�һ�ַ�������ͨ�������ֶ������ݡ���¼�����ݺ�
--��֮�����������֤���ݵ������ԡ�

������Լ���Ļ����﷨��ʽΪ��
   [CONSTRAINT constraint_name��Լ������] <Լ������>

1.����Լ�� primary key ����֤���ݵ�ʵ��������
 
  PRIMARY KEYԼ�����ڶ�������������������Ωһȷ������ÿһ����¼�ı�ʶ������ֵ����ΪNULL��Ҳ�����ظ����Դ�����֤ʵ��������ԡ�
  
  create table student
  ( sno char(8) not null,   -- primary key,  --��1�ַ���
    sname char(8),
    ssex char(2),
    sage int,
    sbir datetime,
    constraint pk_stu primary key(sno)     --��2�ַ���,������
  )
   
 create table sc
 ( sno char(8),
   cno char(5),
   score int,
   constraint pk_sc primary key(sno,cno)   --�����(����й�ͬΪ����)ֻ�������ַ���
  ) 
  
2.Ωһ��Լ�� unique ����֤���ݵ��û�����������

 Ωһ��Լ������ָ��һ�����߶���е����ֵ����Ωһ�ԣ��Է�ֹ�����������ظ���ֵ��
 
 create table student
  ( sno char(8) not null,   
    sname char(8),---unique,   --��1�ַ���  
    ssex char(2),
    sage int,
    sbir datetime,
    constraint pk_stu primary key(sno),
    constraint uq_sname unique(sname)     ----��2�ַ���,������   
  )
 
3. ���Լ��  check ����֤���ݵ��û�����������
 
 ���Լ���������л����������е�ֵ���ü������������������ֵ����֤���ݿ����ݵ������ԡ�
 
  create table student
  ( sno char(8) not null,      --ѧ��
    sname char(8),             --����
    ssex char(2) ,--check(ssex='��' or ssex='Ů'),  --��1�ַ���
    sage int check(sage>=17 and sage<=22),
    sbir datetime,
    constraint pk_stu primary key(sno),
    constraint uq_sname unique(sname),     
    constraint ck_ssex check(ssex='��' or ssex='Ů')    ----��2�ַ���,������   
  )
  
4.��ֵԼ��  not(null) ����֤���ݵ��û�����������
  
  ��ֵ��NULL��Լ�����������Ƿ�������ֶε�ֵΪNULL��NULLֵ����0Ҳ���ǿհף�
  �����������ַ����ġ�NULL���ַ��������Ǳ�ʾ����֪�������� ��ȷ������û�����ݡ�����˼��
  
5.Ĭ��ֵԼ�� default ����֤���ݵ��û�����������
 
 Ĭ��Լ��ָ���ڲ�����������û���ṩ����ֵʱ����ϵͳ�Զ�ָ��ֵ��
 Ĭ��Լ�����԰���������������������Ԫ���ڽ��������߿�ֵ��
 
 ע�⣺�ڹ���ƽ̨�ı�������У�Ĭ��ֵ���ڡ������ԡ�������
 
 create table student
 ( sno char(8) primary key,
   sname char(8),
   ssex char(2),
   sage int,
   sdept varchar(20) default('������ѧԺ'),     --Ժϵ��Ĭ��Ϊ��������ѧԺ
   sbir datetime,
   constraint uq_sname unique(sname),
   constraint ck_ssex check(ssex='��' or ssex='Ů'),
  -- constraint df_sdept default('������ѧԺ')   --���ַ�������
  ) 

  alter table student
  add constraint df_sdept default('������ѧԺ') for sdept
  
6.���Լ��: foreign key ��֤���ݵĲ���������
  
  ��� (FOREIGN KEY) �����ڽ����ͼ�ǿ����������֮������ӵ�һ�л���С��ⲿ��Լ������ǿ�Ʋ��������ԡ�

   ע�⣺�ĸ�����������ĸ�����������������ĸ�����ĸ��н�����ϵ
   
  create table sc
  (sno char(8),-- foreign key references student(sno),
   cno char(5),
   score int,
   constraint pk_sc primary key(sno,cno),
   constraint fk_sc_stu foreign key(sno) references student(sno)    --sc���е�sno�и�student���е�sno�������
  )
  
  use bjglxt
  go
  CREATE TABLE  Course
          (Cno       CHAR(4) PRIMARY KEY,
        	 Cname  CHAR(40),            
         	 Cpno     CHAR(4),               	                      
            Ccredit  SMALLINT,
            FOREIGN KEY (Cpno) REFERENCES  Course(Cno) 
          ); 

 create table student1
(
 Id char(8),
 name char(8),
 sex char(2),
 phonenum char(12),
 constraint chk_sex check(sex in ('F','M')),--  ssex='F' or ssex='M'
 Constraint chk_phonenum check
(phonenum like '010[-][1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)
 
  ALTER TABLE <����>
[ ADD[COLUMN] <������> <��������> [ ������Լ�� ] ]
[ ADD <��������Լ��>]
[ DROP COLUMN  <����> [CASCADE| RESTRICT] ]
[ DROP [CONSTRAINT]<������Լ����>[ RESTRICT | CASCADE ] ]
[ALTER COLUMN <����><��������> ] ;

  create table student
( sno char(8) not null,
  sname char(8) ,
  ssex char(2) ,
  sage int,
  sbir datetime
)
  �޸ı�
  �����ݿ��еı�����ɺ󣬿��Ը�����Ҫ�ı����ԭ�ȶ�������ѡ��Ը��ı�Ľṹ��
  �û��������ӡ�ɾ�����޸��У����ӡ�ɾ�����޸�Լ�������ı����Լ��ı��������ߵȡ�

  ALTER TABLE <����>
[ ADD[COLUMN] <������> <��������> [ ������Լ�� ] ]
[ ADD <��������Լ��>]
[ DROP [ COLUMN ] <����> [CASCADE| RESTRICT] ]
[ DROP CONSTRAINT<������Լ����>[ RESTRICT | CASCADE ] ]
[ALTER COLUMN <����><��������> ] ;

 1.������
 --��student���������У�spiec(רҵ)��varchar(20) '�������ѧ�뼼��'
 alter table student
 add spiec varchar(20) default('�������ѧ�뼼��')
 
 alter table student
 add clno char(8) null
 
 2.ɾ����
 alter table student
 drop column sbir
  
 3.�޸���
 --��student���е�sname �ĳ����޸�Ϊ16
 alter table student
 alter column sname varchar(16) 
 
 4.����Լ��
 alter table student
 add constraint pk_stu primary key(sno)
 
 alter table student
 add constraint ck_ssex check(ssex='��' or ssex='Ů')
 
 5.ɾ��Լ��
 alter table student
 drop ck_ssex
 
 6.�޸ı���
   sp_rename student,stu 
   
 7.ɾ����
 drop table student
 
 drop table sc
 ע�⣺��2����������ϵ������ֻ��ɾ�����������ɾ��������
 
 
 ����
 
 1.����������Ŀ�ģ��ӿ��ѯ�ٶ�
 2.�ڴ������ PRIMARY KEY �� UNIQUE Լ��ʱ�Զ���������
 3.��������
   CREATE UNIQUE INDEX  Stusno ON Student(Sno);
   CREATE UNIQUE INDEX  Coucno ON Course(Cno);
   CREATE UNIQUE INDEX  SCno ON SC(Sno ASC,Cno DESC);
 4.����������Խ��Խ��,��Ϊϵͳά����Щ����Ҫ�������ۣ�һ������²�Ҫ���ⴴ����������ϵͳ�Զ������� PRIMARY KEY �� UNIQUE ����


3.4 ���ݲ�ѯ

���ݲ�ѯ������ָ�����û�����Ҫ��һ�ֿɶ��ķ�ʽ�����ݿ�����ȡ�������ݣ�
�����ݿ�ṹ����ѯ����SQL�ĺ������ݡ� 
  
���ݲ�ѯ���ܶ���ͨ�� SELECT �����ʵ�ֵġ�SELECT �����Դ����ݿ��а����û���Ҫ��������ݣ�
    ������ѯ����Ա�����ʽ����� 

  ����ʽ:
       SELECT [ALL|DISTINCT] <Ŀ���б��ʽ>[,<Ŀ���б��ʽ>] ��
       FROM <��������ͼ��>[,<��������ͼ��> ]��|(SELECT ���)      
                   [AS]<����>
      [ WHERE <�������ʽ> ]
      [ GROUP BY <����1> [ HAVING <�������ʽ> ] ]
      [ ORDER BY <����2> [ ASC|DESC ] ];

1.�򵥲�ѯ
   select ��(��ѯ����)
   from  ��
   
 --��ѯѧ����ѧ�ţ��������Ա�
 select sno,sname,ssex
 from student
 
 select sname,sno,ssex   --��ѯ������еĴ�������еĴ����޹أ��� select�־��е��д���һ��
 from student
 
 select sno ѧ��,sname ����,ssex as �Ա�   --����ȡ����
 from student
 
 --��ѯѧ����������Ϣ
 select *           -- * ����������
 from student
 
 --��ѯѧ����ѧ�ţ�������ʵ������
 select sno,sname,year(getdate())-YEAR(sbir) ʵ������     --��ѯ�����ݿ�����ͨ������õ�,��ʾ�������������ñ���
 from student
 
 print getdate()   --ϵͳ����,getdate():��ȡϵͳ��ǰʱ��
 print year(getdate())  ----ϵͳ����,year():��ȡ��
       month()
       day()
       
 --��ѯ��ʦ�ı�š���������ʦְ�ơ�Ӧ������
  select tno ���,tname ����,ttitle ��ʦְ��,tjbgz+tgwjt Ӧ������
  from teacher
  
  --��ѯѡ���˿γ̵�ѧ����ѧ��
  select distinct sno   --����ѯ����к����ظ���ʱ���� distinct ȥ���ظ���
  from sc
  
 ʹ��TOP �Ӿ䷵��ָ��ǰ�����
�������ָ�ʽ����һ�ָ�ʽ�ǣ���TOP N�����ڶ��ָ�ʽ�ǣ���TOP N PERCENT��

  --��ѯѧ�����е�ǰ5��
  select top 5 *
  from student
  
  select top 5 percent sno,sname,sage
  from student
  
 2.������ѯ
 
 ��Ҫ�ڱ����ҳ�����ĳЩ��������ʱ������ʹ�� WHERE �Ӿ� ָ����ѯ����
 
 select �Ӿ�(����:��ѯ������)
 from �Ӿ�(��)
 where �Ӿ�(�������ʽ)
 
 (1)�Ƚ�:=, >, <, >=, <=, !=, <>, !>, !<; NOT+
 --��ѯŮͬѧ��ѧ����Ϣ
 select *
 from student
 where ssex='Ů'
 
 --��ѯ����ѡ���˿γ�01001�ĳɼ���Ϣ
 select *
 from sc
 where cno<>'01001'
 
 (2)ȷ����Χ:  (not) between   and
 
 --��ѯ�ɼ���80��95��ѧ�š��γ̺ţ��ɼ�
 select sno,cno,score
 from sc
 --where score>=80 and score<=95
 where score between 80 and 95
 
 --��ѯ�ɼ�����80��95��ѧ�š��γ̺ţ��ɼ�
 select sno,cno,score
 from sc
 --where score<80 or score>95
 where score not between 80 and 95
 
 (3)ȷ������: (not) in(ֵ)
 
 --��ѯ200701��200801���ѧ����Ϣ
 select *
 from student
 --where clno='200701' or clno='200801'
 where clno in('200701','200801')
 
 --��ѯ��200701��200801���ѧ����Ϣ
 select *
 from student
 where clno not in('200701','200801')
 
 --��ѯ��01001��01002��02003֮��ĳɼ���Ϣ
 select *
 from sc
 where cno not in('01001','01002','02003')
 
 (4)ģʽƥ��: ģ����ѯ   (not) like 
     ��LIKE �ؼ������ʹ�õ�ͨ���:  % :������������ַ��������ַ���
                                   _ :�κε����ַ�

 --��ѯ�γ����к���'�����'�Ŀγ���Ϣ
 select *
 from Course
 where Cname like'%�����%'
 
 --��ѯ���Ե�ѧ����Ϣ
 select *
 from student
 where sname like'��%'
 -- where left(sname,1)='��'
 
 --��ѯ�����Ե�ѧ����Ϣ
 select *
 from student
 where sname not like'��%'
 
 --��ѯ�ա��ޡ���ȫ��Ϊ�������ֵ�ѧ����������
 select sname
 from student
 where sname like'��__'
 
 --��ѯDB_Design�γ̵Ŀγ̺ź�ѧ�֡�
  SELECT Cno,credits
      FROM     Course
      WHERE  Cname LIKE 'DB\_Design' ESCAPE '\'     --ESCAPE '��' ��ʾ�� �ܡ� Ϊ�����ַ�

 (5)�漰��ֵ�Ĳ�ѯ: is (not) null
    null
 
 --��ѯ�ɼ�Ϊnull�ĳɼ���Ϣ
 select *
 from sc
 where score is null
 
 --��ѯ�ɼ�Ϊ��null�ĳɼ���Ϣ
 select *
 from sc
 where score is not  null
 
 (6)����������ѯ:  and or 
    AND�� OR�����Ӷ����ѯ����
    AND�����ȼ�����OR
    ���������Ÿı����ȼ�
 --��ѯѡ��01001��01002�ҷ������ڵ���85��ѧ����ѧ�š��γ̺źͳɼ���
 select sno,cno,score
 from sc
 where (cno='01001' or cno='01002') and score>=85
 
 (7)�ض������:INTO
   �﷨��ʽ��
     INTO new_table

    --��ѯ�ɼ�<60�ĳɼ���Ϣ������bukao����
    select * into bukao
    from sc
    where score<60
 
  --1.��ѯ�������19���ѧ�������������䡣
  select sname,sage
  from Student
  where Sage>19
--2����ѯ������19����22��(��19���22��)֮���ѧ����ѧ�š����������䡣
  select sno,sname,sage
  from Student
  where Sage between 19 and 22
--3����ѯ���䲻��19����22��֮���ѧ����ѧ�š����������䡣
  select sno,sname,sage
  from Student
  where Sage not between 19 and 22
--4����ѯ200701��200801�༶��ѧ����Ϣ��
   select *
   from Student
   where Clno in('200701','200801')
--5����ѯ������200701��200801�༶��ѧ����Ϣ��
    select *
   from Student
   where Clno not in('200701','200801')
--6����ѯ�����к��С�������ѧ����
   select *
   from Student
   where Sname like'%��%'
--7����ѯѡ�޿γ�01001��02002���ɼ���80��95֮�䣬ѧ��Ϊ20080xxx��ѧ����ѧ�š��γ̺źͳɼ���
   select sno,cno,score
   from SC 
   where (Cno in('01001','02002')) and (Score between 80 and 95) and (Sno like'20080___')
--8����ѯѡ�޳ɼ���Ϊ��ֵ��ѡ����Ϣ��
   select *
   from SC
   where Score is not null
9--.��ѯְ��Ϊ�����ڣ�Ӧ�����ʴ���3000�Ľ�ʦ��Ϣ��
  select *
  from Teacher 
  where Ttitle='������' and (Tjbgz+tgwjt)>3000
  
  
 3.order by �Ӿ�:�����ѯ  
  
  ʹ�� ORDER BY �Ӿ�Բ�ѯ��������������������ѯ�����
   
   order by ���� asc(����)[,����]
   
   ORDER BY ����1 [ASC | DESC]
                  ����,
            ����n [ASC | DESC]
���У��ؼ��� ASC ��ʾ����������DESC ��ʾ����������Ĭ�����������������

   
   --��ѯѧ���ĳɼ���Ϣ�������γ̺���������,���ɼ��Ľ�������
   select *
   from sc
   order by cno asc,score desc
   
  --��ѯȫ��ѧ���������ѯ��������ڰ�İ༶����������У�ͬ�༶�е�ѧ�������併�����С�
  select *
  from student
  order by clno,sage desc

  4.�ۺϺ���:
  
     COUNT(*):ͳ��Ԫ�����

     COUNT([DISTINCT|ALL] <����>):ͳ��һ����ֵ�ĸ���

     SUM([DISTINCT|ALL] <����>):����һ��ֵ���ܺͣ����б���Ϊ��ֵ�ͣ�	

     AVG([DISTINCT|ALL] <����>):����һ��ֵ��ƽ��ֵ�����б���Ϊ��ֵ�ͣ�

 	 MAX([DISTINCT|ALL] <����>):��һ���е����ֵ
 	 
	 MIN([DISTINCT|ALL] <����>):��һ���е���Сֵ

      �ۺϺ���ֻ���������������Ӿ��У�
     (1)SELECT ����ѡ���б���SELECT AVG��score����
     (2)COMPUTE �� COMPUTE BY �Ӿ䡣
     (3)HAVING �Ӿ䡣


  --ͳ��ѧ�����е�ѧ������
    select COUNT(*) ����
    from student
    
    --ͳ��ѧ�����е�Ůѧ������
    select COUNT(*) ����
    from student
    where ssex='Ů'
    
    --ͳ��ѡ���˿γ̵�ѧ������
    select COUNT(distinct sno)
    from sc
    
    --��ѯѡ���˿γ�01001���ܷ֣�ƽ���֣���߷֣���ͷ�
    select SUM(score) �ܷ�,avg(score) ƽ����,max(score) ��߷�,min(score) ��ͷ�
    from sc
    where cno='01001'
    
  5.�����ѯ:group by �Ӿ�
   �﷨��ʽ��
    GROUP BY group_by_expression1 [,group_by_expression2][,��]
      
      ע�⣺
          (1)Ҫ��Ҫ���飬���ĸ���������
          (2)�������к��оۺϺ���ʱ�������� where �Ӿ�,������ having �Ӿ�
          (3) where �Ӿ������� group by ֮ǰ���� having �Ӿ������� group by �Ӿ�֮��
          (4)���� SELECT �Ӿ��г��ۺϺ���֮�����õ��У�Ҳ��������� GROUP BY �Ӿ���
      
      
    --�ֱ�ͳ��ѧ�����е���Ůѧ������
    select ssex,COUNT(*) ����
    from student
    group by ssex
    
    --��ѯÿ��ѧ��ѡ�ε��ܷ֣�ƽ���֣���߷֣���ͷ�
    select sno, SUM(score) �ܷ�,avg(score) ƽ����,max(score) ��߷�,min(score) ��ͷ�
    from sc
    group by sno
    
    --��ѯÿ�ſγ̵��ܷ֣�ƽ���֣���߷֣���ͷ�
    select cno, SUM(score) �ܷ�,avg(score) ƽ����,max(score) ��߷�,min(score) ��ͷ�
    from sc
    group by cno
    
    --��ѯƽ���ɼ����ڵ���90�ֵ�ѧ��ѧ�ź�ƽ���ɼ�                         --
    select sno,avg(score)
    from sc 
    group by sno
    having avg(score)>=90
    
    --��ѯ01001�γ̵��ܷ֣�ƽ���֣���߷֣���ͷ�
    select cno, SUM(score) �ܷ�,avg(score) ƽ����,max(score) ��߷�,min(score) ��ͷ�
    from sc
    where cno='01001'
    group by cno
    
    
    --��ѯѧ����������4�˵İ༶��ż�����Ӧ��ѧ������
    select clno,COUNT(*) ѧ����
    from student
    group by clno
    having COUNT(*)<4
    
    --��ѯƽ���ɼ����ڵ���90�ֵ�ѧ��ѧ�ţ��ɼ����ܷ�                         --
    select sno,score,sum(score)
    from sc 
    group by sno,score
    having avg(score)>=90
    
    
--1����ѯ�γ�01001����ߡ������ƽ���ɼ���
select cno, MAX(score) ��߳ɼ�,MIN(score) ��ͳɼ�,AVG(score) ƽ���ɼ�
from SC
where Cno='01001'
group by Cno
--2����ѯÿ��ѧ��ѡ�޵Ŀγ̵��ܷ֡�ƽ���֣�����ѧ����������
select sno, SUM(score) ��߳ɼ�,AVG(score) ƽ���ɼ�
from SC
group by Sno
order by Sno
--3����ѯ�����ŵĽ�ʦ������
select dno,COUNT(*) ��ʦ����
from Teacher
group by dno

--4����ѯѧ��ѡ�޵Ŀγ�ƽ���������ڵ���70�ֵĿγ̺š�ƽ���ɼ���
  select cno,AVG(score)
  from sc
  group by cno
  having AVG(score)>=70

--5����ѯ���ſγ̵�ѡ��������������������������
  select cno,COUNT(*)
  from sc
  group by cno
  order by COUNT(*) asc

--6����ѯѧ����������4�˵İ༶������Ӧ��ѧ������
   elect clno,COUNT(*) ѧ����
    from student
    group by clno
    having COUNT(*)<4
    
--7����ѯ�γ̺ţ��ɼ����Ȱ��γ̺����������ٰ��ճɼ���������
    select cno,score
    from SC
    order by Cno ,Score desc
--8��ͳ�Ƹ�ְ�ƽ�ʦ������
    select ttitle,COUNT(*) ����
    from Teacher
    group by Ttitle
--9����ѯѡ����2�ſγ����ϵ�ѧ����ѧ�ż����ܳɼ�����ѯ������ܳɼ���������
    select sno,sum(score) �ܳɼ�,COUNT (*) �γ�����
    from SC
    group by Sno 
    having COUNT(*) >2
    order by SUM(score) desc

 
 
 6.���Ӳ�ѯ:ʵ�ֶ�����ѯ
 ���Ӳ�ѯ���Ƚ���������������ӳ�һ�������ڴ���Ľ��������ִ�в�ѯ
  ������: inner join   
     (1)�������������ϵı����������:��1.����=��2.����    �磺 student.sno=sc.sno
     (2)����������������ĸ��Ӿ�:
              a)���� where �Ӿ���
              b)���� from �Ӿ��У��Ƽ��ã�:
                     from  ��1 [inner] join ��2 on ������������1.����=��2.������
                               join ��3 on ��2.����=��3.����
                               join ��4 on ��3.����=��4.����
     
 --��ѯѧ����ѧ�ţ�������ѡ�εĿγ̺ţ��ɼ�
 select sc.sno,sname,cno,score
 from student,sc 
 where student.sno=sc.sno
 
  --��ѯ01001��01002�ҳɼ�����85�ֵĵ�ѧ�ţ�������ѡ�εĿγ̺ţ��γ������ɼ�
 select sc.sno,sname,sc.cno,cname,score
 from student,sc,course 
 where student.sno=sc.sno and sc.cno=course.cno and (sc.Cno in('01001','01002')) and score>85

--��ѯѧ����ѧ�ţ�������ѡ�εĿγ̺ţ��γ������ɼ�
 select sc.sno,sname,sc.cno,cname,score
 from student join sc  on student.sno=sc.sno
              join Course on sc.cno=course.cno
              
 --��ѯѧ����ѧ�ţ��������༶���ƣ��ɼ�
 select student.sno,sname,clname,score
 from sc join student on sc.sno=student.sno
         join Class on student.clno=class.clno
         
 --��ѯѧ����ѧ�ţ��������༶���ƣ��ɼ�
 select s.sno,sname,clname,score
 from sc join student s on sc.sno=s.sno    --��student��ȡ���� s ,һ������ȡ�˱�������������ѯ����ж�Ҫ�øñ���
         join Class c on s.clno=c.clno     --��class��ȡ���� c
 
         
--1����ѯѡ���˿γ�01001�ҳɼ���70�����»�ɼ���90�����ϵ�ѧ�����������γ����ƺͳɼ���
select sname,cname,score
from Student s join SC on s.Sno=sc.Sno
               join Course c on sc.Cno=c.cno
where sc.Cno='01001' and (Score<70 or Score >90)

--2. ��ѯ����ѡ�˿γ̵�ѧ��ѧ�š����������ڰ༶�İ༶���ơ�
select distinct Student.Sno,sname,clname
from SC join Student on sc.Sno=Student.Sno
        join Class on Student.Clno=Class.Clno
--3����ѯ��ѧ��ѡ�޵�ÿ�ſγ̵Ŀγ̺š��γ�����ƽ��������ѧ�ּ��ον�ʦ��������ƽ���������ڵ���70�֡�
  select sc.cno,cname,AVG(score),credits,tname
  from sc join course c on sc.cno=c.cno
          join Teaching t1 on c.cno=t1.Cno
          join Teacher t2 on t1.Tno=t2.tno
  group by sc.Cno,cname,credits,tname
  having AVG(score)>=70
  
--4����ѯ�γ̺š�ѧ�֡��ον�ʦ��ѡ�γɼ��ܷ֣������γ̺���������
select sc.Cno,Credits,Tname,SUM(score)�ܳɼ�
from SC join Course c on sc.Cno=c.Cno
        join Teaching t1 on c.Cno=t1.Cno
        join Teacher t2 on t1.Tno=t2.tno
group by sc.Cno,Credits,Tname
order by sc.Cno

--5����ѯÿ�ſγ̵Ŀγ̺š��γ������ον�ʦ��ѡ������
select sc.Cno,Cname,Tname,COUNT(sc.Cno)ѡ����
from SC join course c on sc.cno=c.cno
        join Teaching t1 on c.Cno=t1.Cno
        join Teacher t2 on t1.Tno=t2.tno
group by sc.Cno,cname,Tname



������(OUTER join)

��������(LEFT OUTER join):�������Ӳ�ѯ�Ľ�������ϣ����������ʣ�µ�������

  select s.*,sc.*
  from student s left outer join sc on s.sno=sc.sno

��������(RIGHT OUTER join):�������Ӳ�ѯ�Ľ�������ϣ��������ұ�ʣ�µ������� 

  select s.*,sc.*
  from  sc right outer join student s on s.sno=sc.sno
  
  
  7.Ƕ�ײ�ѯ:�Ӳ�ѯ
    
    һ�� SELECT-FROM-WHERE ����Ϊһ����ѯ��
   ��һ����ѯ��Ƕ������һ����ѯ��� WHERE �Ӿ�� HAVING ����������еĲ�ѯ��ΪǶ�ײ�ѯ
   ע�⣺
       (1)��ִ���Ӳ�ѯ��Ȼ����Ӳ�ѯ�Ľ����Ϊ����ѯ��������
       (2)�Ӳ�ѯ�븸��ѯ���ӵķ�ʽ������: 
                      a)���Ӳ�ѯ�Ľ��Ϊ1��ʱ���ñȽ���������� =  > < => =< <> !=
                      b)���Ӳ�ѯ�Ľ��Ϊ���ʱ����  (not) in
       (3)�Ӳ�ѯ������(select Ŀ����)�ɸ���ѯ����������

  --��ѯ��������ѧ����Ϣ
  select *                --����ѯ
  from student
  where sage= (select max(sage) from student)    --�Ӳ�ѯ  
  
  --��ѯѡ���˿γ̵�ѧ����Ϣ
  select *
  from student
  where sno in(select distinct sno from sc)
  
  --��ѯû��ѡ�޿γ̵�ѧ����Ϣ
  select *
  from student
  where sno not in(select distinct sno from sc)
  
 --1����ѯ�� ����ά���� ������ͬ��ѧ���������ͳ������¡�
select sname,year(Sbir) ��,MONTH(sbir) ��
from Student
where Sage=(select Sage from Student where Sname='��ά��')
      and Sname!='��ά��'
--2����ѯѡ���ˡ���������硱��ѧ����ѧ�š��������ɼ���
   select sc.sno,sname,score
   from student join sc on student.sno=sc.sno
   where cno=(select cno from Course where Cname='���������')


--3����ѯ�� ����һ�� ͬ�࣬��������� ���������� ��ѧ������Ϣ�� 
  select *
  from student
  where clno=(select clno from student where sname='��һ��')
        and sage>(select sage from student where sname='������')

--3����ѯ�� ����һ�� ͬ�࣬��������� ���������� ��ѧ������Ϣ��
select *
from Student
where Clno=(select Clno from Student where Sname='��һ��')
      and Sage>(select Sage from Student where Sname='������')
--4����ѯû��ѡ�޿γ̵�ѧ����Ϣ����
select *
from student
where sno not in (select distinct sno from sc)
--5����ѯѡ���˿γ̡�01001�������롮������ͬ���ѧ����Ϣ��
select *
from Student join SC on Student.Sno=SC.Sno
where Cno='01001'
      and Clno =(select Clno from Student where Sname='����')
      
  select *
  from Student 
  where sno in(select sno from sc where Cno='01001')
      and Clno =(select Clno from Student where Sname='����')
          
--6����ѯ�����н�ʦְ����ͬ���һ������ʴ��ڡ������С��Ľ�ʦ�š�������ְ�ƺͻ������ʡ�
select tno,tname,ttitle,tjbgz
from Teacher 
where Ttitle =(select Ttitle from Teacher where Tname='����')
      and Tjbgz>(select Tjbgz from teacher where Tname ='������')
  
  
  3.5 ���ݸ���
 
   1.��������:
   ����ʽ:
	insert into <����> [(<������1>[,<������2 >��)]
	VALUES (<����1> [,<����2>]�� );   --ֻ�ܲ���һ������
   ����:
    ����Ԫ�����ָ������
    
    ע�⣺(1)�������ĳ���ֵֻ�Ǳ�Ĳ�����ֵ�������ڱ����������Ӧ�Ĳ�������(����ȱʡΪ�� null ����)
    
    --����һ���ɼ���Ϣ��20070101��02001��90
    insert into sc
    values('20070101','02001',90)
    
    insert into student(sno,clno,sname) 
    values('2021001','201001','����')
    
    insert into student(sno,sname) 
    values('2021002','����')


    ����ʽ:
    INSERT INTO <����>  [(<������1> [,<������2>��  )]
 	�Ӳ�ѯ;     --���Ӳ�ѯ�Ķ������ݲ��뵽����,������Ǵ���
 	
 	
 	select * into stu
 	from student 
 	where ssex='��'
 	
 	  insert into stu
 	  select *
 	  from student
 	  where ssex='Ů'
 	  
  2.�޸�����
   ����ʽ:
    UPDATE  <����>
    SET  <����>=<���ʽ>[,<����>=<���ʽ>]��
    [WHERE <����>];
    
    --�Ѽ���������ѧ���޸ĳ�5��
    update Course
    set credits=5
    where Cname='���������'
    
    --��Student���С�������ͬѧ�������޸�Ϊ���غ졯�������Ա��ΪŮ��
    update student 
    set sname='�غ�' , ssex='Ů'
    where sname='����'
    
   -- ��Course���С�C���Գ������ ��ѧ�����޸ĳ��롮���ݿ�ԭ��Ӧ�á���ѧ������ͬ��
   update Course
   set Credits=(select Credits from Course where Cname='���ݿ�ԭ��Ӧ��')
   where cname='C���Գ������'

  3.ɾ������
   ����ʽ:
       delete from   <����>
       [WHERE <����>];
����:ɾ��ָ����������WHERE�Ӿ�������Ԫ��

--ɾ��SC����ѧ��Ϊ��20070101���ĳɼ���Ϣ��
  delete from sc
  where Sno='20070101'
 
  
  
  
  3.7 ��ͼ
  
  1.��ͼ�ĸ��
    ��ͼ�Ǹ�����Ǵ�һ�����߶�������ͼ�е����ı���ṹ�������ǽ����ڶԱ�Ĳ�ѯ�����ϵģ�
     ������ʾ�κ��������ݣ���ֻ�������鿴���ݵĴ��ڶ��ѡ�
  (1)����Ǵ�һ���򼸸�����������ͼ�������ı�
  (2)ֻ�����ͼ�Ķ��壬�������ͼ��Ӧ������
  (3)�����е����ݷ����仯������ͼ�в�ѯ��������Ҳ��֮�ı�
   
 2.������ͼ
   ����ʽ:
      create view  <��ͼ��>  [(<����>  [,<����>]��)]
       AS  <�Ӳ�ѯ>
   
   create view view1
   as
    select s.sno,sname,sc.cno,cname,score,credits
    from student s join sc on s.sno=sc.sno
                   join Course c on sc.cno=c.cno
       
   --������ͼview2:sno,clname,cno,score
    create view view2
    as
      select s.sno,clname,cno,score
         from sc join student s on sc.sno=s.sno
                 join Class c on s.clno=c.clno
                 
                 
   --������ͼview3:  sno,sname,clname,cno,cname,score,credits  
   create view view3 
   as 
     select view1.sno,sname,view1.cno,cname,view2.score,credits
     from  View1 join view2 on view1.sno=view2.sno 
     
    create view view4(sno,sname,cno,score)
    as
     select sc.sno,sname,cno,score
      from sc join student s on sc.sno=s.sno
   
    create view view5
    as
    select *
    from student
    where clno='200701'
   
   3.��ͼ������ :��ȫ��
   (1)ͨ����ͼ��ѯ����
     select sno,sname,cno,score,credits
     from view1
     
    (2)ͨ����ͼ��������в�������
    
    insert into view5(sno,clno,sname)     --����ͼview5�в���һ�����ݣ�ͬʱ�ڻ�����student��Ҳ������ͬһ������
    values('20070105','200701','����')
    
    
    --����һ��Tea_view1�Ľ�ʦ��ͼ�����Tno��Tname��Tsex����ͨ����ͼ����һ����ʦ��Ϣ .
    create view Tea_view1
    as 
      select tno,tname,tsex
      from Teacher
      
    insert into Tea_view1
    values('02007','����','Ů') 
    
    (2)ͨ����ͼ�޸Ļ�����������
     
    --��sc�Ͻ���һ��sc_view2��ѧ����ͼ����ͨ������ͼ������01001�Ŀγ̳ɼ�����5�֡�
    create view sc_view2
    as
     select *
     from sc
     
     update sc_view2     --�޸���ͼsc_view2�е����ݣ�ͬʱ�ڻ�����sc��Ҳ�޸�����ͬ���� 
     set score=score+5
     where cno='01001'
    
    (3)ͨ����ͼɾ��������������
    
    delete from view5
    where sno='20070103'
    
         create VIEW S_G(Sno,Gavg)
             AS  
             SELECT Sno,AVG(score)
             FROM  SC
             GROUP BY Sno;


  --1��������ʾѧ�š��������γ̱�š��ɼ�����ͼsc_view1����ͨ������ͼsc_view1��SC�����һ�����ݡ�
create view sc_view1
as 
  select SC.sno,Sname,Cno,Score 
  from Student join SC on Student.Sno=SC.sno

insert into sc_view1(Sno,Sname,Cno,Score)
values('2001003','����','01001','95')
ԭ����ͼ���� 'sc_view1' ���ɸ��£���Ϊ�޸Ļ�Ӱ��������

--2������һ��Tea_view1�Ľ�ʦ��ͼ�����Tno��Tname��Tsex����ͨ����ͼ����һ����ʦ��Ϣ .
create view Tea_view1
as 
  select tno,tname,tsex
  from teacher
  
  insert into Tea_view1
  values('02009','�·���','��')

--3����sc�Ͻ���һ��sc_view2��ѧ����ͼ����ͨ������ͼ������01001�Ŀγ̳ɼ�����5�֡�
  create view sc_view2
  as 
   select *
   from SC
   
  update sc_view2
  set Score=Score+5
  where Cno='01001'
--4������ʦ��Ϣ��Teacher�Ͻ���һ��Tea_view2�Ľ�ʦ��ͼ����ͨ����ͼ����һ����ʦ��Ϣ('02005','����','��',1981-09-28,'��ʦ','0003',1800,780)��
  create view Tea_view2
  as
  select * 
  from Teacher
  
  insert
  into Tea_view2
  values('02005','����','��','1981-09-28','��ʦ','0003',1800,780)
--5������ʦ��Ϣ��Teacher�Ͻ���һ��Tea_view4�Ľ�ʦ��ͼ����ͨ����ͼ�����и����ڵĻ������ʣ�Tjbgz���ϵ�500Ԫ����
  create view Tea_view4
  as
  select *
  from Teacher
  
  update Tea_view4
  set Tjbgz=Tjbgz+500
  where Ttitle='������'
--6������ʦ��Ϣ��Teacher�Ͻ���һ��Tea_view6�Ľ�ʦ��ͼ����ͨ����ͼ������ְ���ǽ�ʦ�Ľ�ʦɾ����
  create view Tea_view6
  as
  select *
  from Teacher
  
  delete from Tea_view6
  where Ttitle='��ʦ' 
   
    
    --7.����ʦ��Ϣ��Teacher�Ͻ���һ��ְ���Ǹ����ڡ��������ʴ��ڵ�2000Ԫ�Ľ�ʦ��ͼview_teacher����ͨ����ͼview_teache��
    --������ʦ�������һ����¼����ɾ���ա������Ľ�ʦ���۰�������ڵ���35�Ľ�ʦ�Ļ��������ϵ�300Ԫ��
    create view view_teacher 
    as
     select *
     from Teacher
     where Ttitle='������' and Tjbgz>=2000
    
    
     insert into view_teacher(Tno,tname)
     values('02008','�»�')
     
     delete from view_teacher
     where Tname  like'��%'
     
     update view_teacher
     set Tjbgz=Tjbgz+300
     where (year(GETDATE())-YEAR(tbir))>=35
   
   
  
  ��8�� ���ݿ���
 
  1.����:
   �ӱ��������÷�Χ�����֣�SQL Server�ṩ������ʽ�ı������ֲ�������ȫ�ֱ�����
   ȫ�ֱ���:��ϵͳ���岢ά����ͨ��������ǰ��ӡ�@@������
   �ֲ�����:������ĸΪ������@��
   
   (1)�������
   ʹ��DECLARE��������ֲ�����
  ��ʽ��DECLARE @<������> <��������>[,@<������> <��������>]...
   �ֲ��������������������������ֲ��������������洢���̻�����
   
   declare @sno char(8),@num int
   
   (2)�ֲ�������ֵ

  ����һ:ʹ�� SET ���
   �磺set @cname = '���������'

  ������:ʹ�� SELECT ��� 
   �磺select  @cname = '���������'
       select @num =COUNT(*) FROM Student    --select��ʵ�ֲ�ѯ����ʵ�ְѲ�ѯ�Ľ�������ֲ����� 
       
     
  (3)��ȡ(���)������ֵ

 ����һ:ʹ�� SELECT ���:�Ա����ʽ���
   �磺select  @cname

 ������:ʹ��PRINT���:���ı���ʽ���
     �磺print @cname


  declare @num int 
  select @num =COUNT(*) FROM Student
  select @num ����
  print @num
  
  --����@cname ��@num������Ȼ�󽫿γ̱��Ϊ01001�Ŀγ�������@cname�����У���ѡ����������@num������
  --������ @cname������@num������ֵ��
  declare @cname char(20),@num int
  select @cname=cname,@num=COUNT(*) 
  from  sc join Course on sc.cno=course.cno 
  where sc.Cno='01001'
  group by sc.cno,cname
  select @cname �γ���,@num ѡ������
  
  SELECT getdate( )  AS  '��ǰ��ʱ�ں�ʱ��', 
         @@connections AS  '��ͼ��¼�Ĵ���'


  2.���̿������
  
  (1)ѡ����� IF��ELSE ���
  IF...ELSE ���﷨��ʽΪ��
  IF Boolean_expression
    { sql_statement | statement_block } --�������ʽΪ��ʱִ��
  [ ELSE
    { sql_statement | statement_block } ] --�������ʽΪ��ʱִ��
  
  
  --��EXISTSȷ����student���Ƿ����ĳ��ͬѧ��
  
   DECLARE @name varchar(40),@msg varchar(255)
   SELECT @name='����'
   IF EXISTS(SELECT * FROM student WHERE sname=@name)
      BEGIN
         SELECT @msg='������Ϊ'+@name
         SELECT @msg
      END
   ELSE
      BEGIN
         SELECT @msg='û������Ϊ'+@name
         SELECT @msg
      END
      
      
 (2)ѡ����� CASE ��� 
 
 CASE ������������������Ϊÿ���������ص���ֵ��
 
  (a) �� CASE ��������ĳ�����ʽ��һ��򵥱��ʽ���бȽ���ȷ�������
    CASE input_expression
       WHEN when_expression THEN result_expression
       [ ...n ]
       [ELSE else_result_expression ]
    END
    
    --��ѯ��ʦ�ı�ţ��������Ա�ְ�ƣ�ְ����𣺽��ڻ򸱽���Ϊ�߼�ְ�ƣ���ʦΪ�м�ְ�ƣ�����Ϊ�ͼ�ְ��
    select tno,tname,tsex,ttitle,
         case ttitle
             when '����' then '�߼�ְ��'
             when '������' then '�߼�ְ��'
             when '��ʦ' then '�м�ְ��'
             else '�ͼ�ְ��'
         end ְ�����
    from teacher




 (b) CASE ����������CASE ����һ���߼����ʽ��ȷ�������
    CASE   
      WHEN Boolean_expression THEN result_expression
         [ ... n ]
         [ ELSE else_result_expression ]
      END

  --��ѯѧ����ѧ�ţ��������γ̺ţ��γ������ɼ����ɼ��ȼ���>=90,�����㣬>=80,�����ã�>=70,���еȣ�>=60���򼰸񣻷���Ϊ������
   select s.sno,sname,sc.cno,cname,score,
       case    
           when score>=90 then '����'
           when score>=80 then '����'
           when score>=70 then '�е�'
           when score>=60 then '����'
           else '������'
       end  �ɼ��ȼ�
  from student s join sc on s.sno=sc.sno
                 join course c on sc.cno=c.cno


(3)ѭ������ WHILE ���
  
   --��1�ӵ�100��ֵ
   declare @i int,@sum int
   set @i=1
   set @sum=0
   while @i<=100
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   PRINT  '1+2+��+100='+CAST(@sum  AS  char(25))   --case()Ϊϵͳ�������Ծֲ�������������ת��

 
 (4)��ת��� GOTO
 
  ʹ��GOTO������ʹSQL����ִ��������������ת�Ƶ�ָ���ı��λ��
   Label:
     ����
    GOTO label
    
    --��1�ӵ�100��ֵ
   declare @i int,@sum int
   set @i=1
   set @sum=0
   a:
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   if @i<=100
   goto a
   PRINT  '1+2+��+100='+CAST(@sum  AS  char(25))
   
  (5)RETURN ��� 
    RETURN ����ʹ������������洢���̻򴥷������������˳�������ִ�б����֮����κ���䡣
    
   
  (6)����ִ����� WAITFOR 
    ʹ�� WAITFOR ��������ĳһ��ʱ�̻�ĳһ��ʱ������ִ��SQL��������顣
    WAITFOR ����������߶���һ��ʱ�䣬����һ��ʱ�������ڶ����ʱ���ڻ��߾��������ʱ����ʱ������Transact-SQL���ᱻִ�С�
    WAITFOR ����ʽ���£�
     WAITFOR {DELAY 'time'|TIME 'time'} 

     waitfor delay '00:00:05'
     select * from student
     
      waitfor time '15:36:00'
      select * from student
     
    
  --8���ж��Ƿ��н�ʦ�ĸ�λ��������1200�����������н�ʦ�ĸ�λ��������100��ֱ�����н�ʦ�ĸ�λ��������1200���ϡ�
   while exists(select * from teacher where Tgwjt<1200)
       update Teacher 
       set Tgwjt=Tgwjt+100
       
 --1�������������εľֲ�������@a1��@a2������@a1����ֵ10����@a2��ֵ@a1*5������ʾ@a2�Ľ����
declare @a1 int,@a2 int 
--select @a1=10,@a2=@a1*5
set @a1=10
set @a2=@a1*5
print @a2
--2����EXISTSȷ����Student���Ƿ���ڡ��������������������ӡ��Student������ѧ������Ϊ��������ͬѧ���������ӡ��Student���в�����ѧ������Ϊ��������ͬѧ����
declare @name varchar(20),@msg varchar(255)
select @name='������'
if exists(select* from Student where Sname=@name)
   begin
      select @msg='������Ϊ'+@name
      select @msg
   begin
   end
else
   begin
      select @msg='û������Ϊ'+@name
      select @msg
   end
--3��ʹ��while���ʵ�ּ���5000��1����2����3����һֱ����50�Ľ��������ʾ���ս��
declare @i int,@sum int
set @i=1
set @sum=5000
while @i<=50
begin
set @sum=@sum-@i
set @i=@i+1
end
print @sum


--4����������Ľ�ʦ��ţ����ظý�ʦ��Ŷ�Ӧ��ʦ���������Ա𡢳������¼�ְ�ơ�
DECLARE @Tno varchar(40)
select @Tno='01001'
if exists(select * from Teacher where Tno=@Tno)
   begin
   select Tname,Tsex,year(Tbir),month(Tbir),Ttitle
   from Teacher 
   where Tno=@Tno  
   end 
   
--5����ʾ����ͬѧ��ѧ�š�������ϵ�����ͣ�ϵ�����ͷ�Ϊ�Ŀ�ϵ�����ϵ��������ѧϵ�������ϵ����������Ϣ����ϵ�������ϵ�����������Ŀ�ϵ��
 select sno,sname,
   case dname
    when '��ѧϵ '  then'���ϵ'
    when '�����ϵ' then '���ϵ'
    
    when '��������Ϣ����ϵ' then '���ϵ'
    else '�Ŀ�ϵ'
   end
 from student s join class c on s.clno=c.clno
               join department d on c.dno=d.dno




--6����ѯѧ����ѧ�ţ��������༶��ѡ�޿γ�������ɼ������ѳɼ�ת���ɡ�A����>=90������B�� ��>=80���� ��C�� ��>=70���� ��D�� ��>=60�� ��E�� ��<60���ȼ���
select s.sno,sname,clno,cname,score,
    case 
    when score>=90 then 'A'
    when score>=80 then 'B'
    when score>=70then 'C'
    when score>=60then 'D'
    else '���ϸ�'
    end �ȼ�
    from Student s join sc on s.Sno=sc.Sno
                   join Course c on sc.Cno=c.cno
    

--7������goto��������1�ӵ�100���ܺ͡�
declare @i int,@sum int
set @i=1
set @sum=0
 a:
begin
set @sum=@sum+@i
set @i=@i+1
end
if @i<=100
goto a
print @sum



--8���ж��Ƿ��н�ʦ�ĸ�λ��������800�����������н�ʦ�ĸ�λ��������100��ֱ�����н�ʦ�ĸ�λ��������800���ϡ�
if exists(select* from Teacher where Tgwjt<800)
update Teacher
set Tgwjt=Tgwjt+100





--9����������@x, @yΪ���ͣ����@x>@y��������ִֹ�У��������ȴ�10���ӣ���ѯѧ����Ϣ��
--���ҳ�����'17:20'ʱ��㲢���浽stu_info��
declare @x int ,@y int
select @x=1,@y=2
if @x>@y
   begin
     return
   end
else 
  begin
     waitfor delay '00:00:10'
     select* from student

    waitfor time '17:20:00'
    select * into stu_info
     from student
  end

  
 8.2 �洢����
  
  1.�洢���̵ĸ���
    �洢������Ϊ����ض��Ĺ��ܶ��㼯��һ���һ��SQL������䣬�������洢�����ݿ��е�SQL����
    
   2. �����洢����
   
    CREATE  PROCEDURE  �洢��
       [@������  ��������][OUTPUT]
        AS  
          SQL���(�������)

   ˵����
�� ֻ���ڵ�ǰ���ݿ��д����洢���̡�
�� ����OUTPUTѡ������Ϊ���������ִ�д洢����ʱ����ҲҪ��OUTPUT����ȱʡ����Ϊ���������
�� ��������Ĺ��ܣ��Ѵ洢�����е����ݴ��䵽�ⲿ��
�� ��������Ĺ��ܣ��ѵ��ⲿ���ݴ��䵽�洢�����С�



    EXECUTE  �洢������
   [ʵ����[��OUTPUT][����]


  --�����洢����p1:��1�ӵ�100��ֵ 
  create procedure p1
  as
   declare @i int,@sum int
   set @i=1
   set @sum=0
   while @i<=100
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   PRINT  '1+2+��+100='+CAST(@sum  AS  char(25))
   
   execute p1
   
   --�����洢����p2����ѯѡ���ˡ��ߵ���ѧ���γ�ѧ���Ŀ���������г�ѧ�����������γ����Ϳ��Գɼ�
   create proc p2
   as
     select sname,cname,score
     from student s join sc on s.sno=sc.sno
                    join Course c on sc.cno=c.Cno
     where Cname='�ߵ���ѧ'
     
   exec p2 
   
   --�����洢����p3:��1�ӵ�ָ��ֵ��ֵ  
  create proc p3
  @n int      --1���������
  as 
   declare @i int,@sum int
   set @i=1
   set @sum=0
   while @i<=@n
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   PRINT  '1+2+��+@n='+CAST(@sum  AS  char(25))
   
   exec p3 245
   
  �����洢����p4:��ѯĳ��ѧ��ĳ�ſγ̵Ŀ��Գɼ�����û��ָ���γ̣���Ĭ�Ͽγ�Ϊ����ѧ������ 
  create proc p4
  @sno char(8),
  @cname char(20)='��ѧ����'
  as
    select sno,sc.cno,cname,score
    from sc join Course c on sc.cno=c.Cno
    where sno=@sno and Cname=@cname
  
  exec p4 '20080101'
  exec p4 '20080101','�ߵ���ѧ'      --��λ�ô���ֵ������һһ��Ӧ
  exec p4 @cname='C���Գ������',@sno='20070101'    --������������
   
 �����洢����p5:--��ѯָ����š�ָ���Ա��ѧ����������ڵ���ָ�������ѧ���������
 --��ŵ�Ĭ��ֵΪ��200801����Ĭ���Ա�Ϊ���С���Ĭ�ϵ�����Ϊ20��
 create proc p5
 @clno char(8)='200801',
 @ssex char(2)='��',
 @sage int=20
  as
    select *
    from student
    where clno=@clno and ssex=@ssex and sage>=@sage 
   
  exec p5
  exec p5 '200701' 
  exec p5 @ssex='Ů'
  exec p5 @ssex='Ů',@sage=25
   
 --1��������ѯÿ��ѧ����ѡ�޿γ���ѧ�ֵĴ洢����p1��Ҫ���г�ѧ�ź���ѧ�֡���ִ�д˴洢���̡�
create proc p1
as
  select sno,SUM(score)
  from sc
  group by sno

exec p1  
--2��������ѯѧ����ѧ�š��������γ̺š��γ������γ�ѧ�ֵĴ洢����p2����ѧ�����ڵ�ϵ��Ϊ���������
--ִ�д˴洢���̣����ֱ�ָ��һЩ��ͬ���������ִ�д˴洢���̡�
create proc p2
@dno char(20)
as
  select s.sno,sname,sc.cno,cname,credits
  from class c1 join Student s on c1.Clno=s.clno
                join sc on s.Sno=sc.Sno
                join Course c on sc.Cno=c.Cno
  where dno=@dno    
 
 exec p2 '0001'            
--3����������1+2+3����..һֱ�ӵ�ָ��ֵ�Ĵ洢����p3��Ҫ�󣺼������ֵ���������������������������������ظ������ߡ���ִ�д˴洢���̡�
--4�������޸�ָ���γ̵�ѧ�ֵĴ洢����p4���������Ϊ���γ̺ź��޸ĺ��ѧ�֣��޸ĺ��ѧ��Ĭ��ֵΪ3����ִ�д˴洢���̡�
create proc p4
@cno char(8),
@credits int=3
as
  update Course
  set Credits=@credits
  where Cno=@cno

exec p4 '01001'
exec p4 '01001',4
--5��������ѯѧ����ѧ�š��������γ������γ�ѧ�֡�ѡ�γɼ��Ĵ洢����p5����ѧ��������Ϊ���������ִ�д˴洢���̡�
create proc p5
@sname char(8)
as
  select s.sno,sname,cname,credits,score
  from Student s join sc on s.Sno=sc.Sno
                 join Course c on sc.Cno=c.Cno
  where Sname=@sname
  
  exec p5 '������'
--6�������洢����p6������һ��ѧ����ѧ�ţ�ͨ������������ظ�ѧ����������ƽ���֡���ִ�д˴洢���̡�
create proc p6
@sno char(8),
@sname char(8) output,
@avg int output
as
  select @sname=sname,@avg=AVG(score)
  from Student s join sc on s.Sno=sc.Sno
  where s.sno=@sno
  group by s.sno,sname
  
  declare @sname char(8),@avg int
  exec p6 '20080102',@sname output,@avg output
  select @sname ����,@avg ƽ����
  
  
--7������һ���洢����p7ɾ��course���ָ���γ̺ŵļ�¼����ִ�д˴洢���̡�
create proc p7
@cno char(8)
as
  delete from Course
  where Cno=@cno 
  
  exec p7 '02004'
--8�������洢����p8����ѯָ����š�ָ���Ա��ѧ����������ڵ���ָ�������ѧ�����������ŵ�Ĭ��ֵΪ��200801����Ĭ���Ա�Ϊ���С���Ĭ�ϵ�����Ϊ20����ִ�д˴洢���̡�
--9.�޸Ĵ洢����p6��ʹ֮����γ̺ţ�ͨ������������ظÿγ̵Ŀγ�����ѧ�ּ��ον�ʦ��������ִ�д˴洢���̡�
alter proc p6
@cno char(8),
@cname char(20) output,
@credits int output,
@tname char(8) output
as
   select @cname=cname,@credits=credits,@tname=tname
   from Course c join Teaching t1 on c.Cno=t1.Cno 
                 join Teacher t2 on t1.Tno=t2.Tno
   where c.Cno=@cno              

declare @cname char(20),@credits int,@tname char(8)
exec p6 '01002',@cname output,@credits output,@tname output
select @cname,@credits,@tname

--10.ɾ���洢����p1,p2,p9��
  drop proc p1,p2,p9
 
   
 ��5�� ������
 
 1.�������ĸ���
 
   ��������һ���������͵Ĵ洢����
   ��������Ҫ��ͨ���¼����д�������ִ�еģ����洢���̿���ͨ����������ֱ�ӵ��á�
   ����ĳһ����� UPDATE��INSERT��DELETE ����ʱ��SQL Server �ͻ��Զ�ִ�д������������SQL��䣬�Ӷ�ȷ�������ݵĴ�������������ЩSQL���������Ĺ���
  ����������Ҫ���þ����ܹ�ʵ������������������ܱ�֤�Ĳ��������Ժ����ݵ�һ���ԡ�

2.����������

  create trigger ��������
  on ����
  for �¼�
  as
     SQL ���
     
     
  --����������tr1:����ѧ����ɾ��ʱ����ʾ��ɾ���ɹ�����ѧ����ѧ��   
  create trigger tr1
  on student
  for delete
  as
    --print'ɾ���ɹ�����ѧ����ѧ'
    select * from deleted
    DECLARE @msg varchar(50)
   SELECT @msg=STR(@@ROWCOUNT)+'��ѧ����ѧ'
   SELECT @msg
   RETURN
    
    
  delete from student
  where clno='200802'
  
 �ڴ�������ִ�й����У�SQL Server �����͹���������ʱ�������Deleted���Inserted��
 ��������������ڼ����������Ĳ����в����ɾ�������м�¼��
  Deleted��:��ִ�� DELETE �� UPDATE ���ʱ���Ӵ���������б�ɾ������
  Inserted��:��ִ�� INSERT �� UPDATE ���֮�����б���ӻ򱻸��µ���
  
  create trigger tr2
  on sc
  for insert,update
  as
    select * from inserted
    select * from deleted
  
  insert into sc
  values('20080104','01001',90)  
  
  update sc
  set score=score+5
  where cno='01001'
  
  ����������tr4:��sc��ʵ��������ͳɼ�������ڵ���0��
  create trigger tr4
  on sc
  for insert,update
  as
    select * from inserted 
    if  exists(select * from inserted where score<0)
    begin
      rollback   --����ع�,����
      print'�ɼ�������ڵ���0'
    end 
     
     
  insert into sc
  values('20080104','01002',-90)
  
  ����������tr5:��SC���ж���һ������ѧ��ѡ���������ܳ���5�š�
  create trigger tr5
  on sc
  for insert
  as
    select * from inserted 
    declare @sno char(8),@n int
    select @sno=sno from inserted 
    select @n=COUNT(*) from sc where sno=@sno
    if @n>5
      begin
      rollback   --����ع�,����
      print'ѡ���������ܳ���5��'
    end 
      
      
  insert into sc
  values('20080104','03003',90)
  
 drop trigger tr1,tr2,tr3,tr4,tr5 
 
 
--1������һ��������������Student�����������ʱ�������ӵ�ѧ�������䲻��12�ꡫ60��֮�䣬�򽫽�ֹ�����ѧ����
 create trigger tr1
 on student
 for insert
 as
    select * from inserted 
    if  exists(select * from inserted where sage not between 12 and 60)
    begin
      rollback   
      print'���������12�ꡫ60��֮��'
    end  
  
  insert into student(sno,clno,sname,ssex,sage) 
  values('20080105','200801','����','Ů',10)
   
--2������һ������������ɾ��Teacher���еĽ�ʦ��Ϣʱ�����Ҫɾ���Ľ�ʦ��ְ���Ǹ������ϣ��򽫽�ֹɾ���˽�ʦ��
create trigger tr2
on teacher 
for delete
as
  if  exists(select * from deleted where Ttitle='����' or Ttitle='������')
    begin
      rollback   
      print'��ֹɾ��ְ���Ǹ������ϵĽ�ʦ'
    end 
    
  delete from Teacher
  where Tno='01004' 
   
--3����SC���ж���һ�����ºͲ��봥�������ڴ˴������б�֤�ɼ���0~100��Χ�ڡ�
  create trigger tr3
  on sc
  for insert,update
  as
    if  exists(select * from inserted where score not between 0 and 100)
    begin
      rollback   --����ع�,����
      print'�ɼ�������0~100��Χ��'
    end 
     
     
  insert into sc
  values('20080104','01002',-90)
--4������һ�������������޸�Teacher����ְ��Ϊ��ʦ�Ľ�ʦ�Ļ�������ʱ������޸ĵ�ֵ����1700�������޸Ĵ˽�ʦ�Ļ������ʡ�
  create trigger tr4
  on teacher
  for update
  as
    if  exists(select * from inserted where Ttitle='��ʦ' and Tjbgz>1700)
    begin
      rollback   --����ع�,����
      print'ְ��Ϊ��ʦ�Ľ�ʦ�Ļ������ʲ��ܴ���1700'
    end 
    
    update Teacher
    set Tjbgz=1800
    where Tno='02002'
--5��ΪSC����һ��insert����������SC�в���ļ�¼�е�ѧ����student����û�е�ѧ�ţ�����ʾ�����ܲ���ü�¼����������ʾ��¼����ɹ���
   create trigger tr5
   on sc
   for insert
   as
    declare @sno char(8)
    select @sno=sno from inserted
    if exists(select * from student where sno!=@sno)
      begin
        rollback   
        print'ѧ�����в����ڸ�ͬѧ�����ܲ��ܲ���ü�¼'
      end 
    else
      print'��¼����ɹ�'
      
   insert into sc
  values('20080105','02001',90)
      
--6����COURSE���϶���һ������ɾ����ѧ��ѡ�޵Ŀγ̵Ĵ�������
  create trigger tr6
  on course
  for delete
  as
    declare @cno char(8)
    select @cno=cno from deleted
    if exists(select * from sc where cno=@cno)
      begin
        rollback   
        print'����ɾ���ÿγ̣���Ϊ��ѧ��ѡ���˸ÿγ�'
      end 
    
  delete from Course
  where Cno='01001'  
    
   
 