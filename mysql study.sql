
--注意：(1)SQL语句中所有的符号都必须是半角（英文状态）
        (2)不区分大小写

--创建数据库
create database bjglxt
create database a2

--重命名数据库
sp_renamedb a1,a2

--删除数据库
drop database a1,a2

表的创建

表(基本表)：存储数据

1.利用SQL Server管理平台创建表：表设计器
   确定表的结构：
            (1)列名(属性)
            (2)数据类型
            (3)是否为null
            (4)设置约束(主键等)
            
2.利用Transact-SQL语句命令创建表

--创建学生表student

create table student
( sno char(8) not null,
  sname char(8) ,
  ssex char(2) ,
  sage int,
  sbir datetime
)

--创建了一个工人信息表，它包括工人编号、姓名、
--性别、出生日期、职位、工资和备注信息。

create table worker
( number char(8) not null,   --工人编号
  name char(8) not null,     --姓名
  sex char(2) ,              --性别
  birthday datetime ,         --出生日期
  job_title varchar(10) ,     --职位
  salary money ,              --工资
  memo ntext                   --备注信息  
)

--创建一个成绩表：学号，课程号，平时成绩，期考成绩，总评成绩（平时成绩*0.4+期考成绩*0.6）
create table chengjibiao
( sno char(8) not null,
  cno char(5) not null,
  pscj int,
  qkcj int,
  zpcj  as pscj*0.4+qkcj*0.6
)

CREATE TABLE autouser
( 编号 int identity(1,1) NOT NULL,
  用户代码 varchar(18),
  登录时间 AS Getdate(),    --系统函数，Getdate():获取系统时间
  用户名 AS User_name()      --系统函数
)



创建约束 
--约束是SQL Server提供的自动保持数据库完整性的一种方法，它通过限制字段中数据、记录中数据和
--表之间的数据来保证数据的完整性。

完整性约束的基本语法格式为：
   [CONSTRAINT constraint_name（约束名）] <约束类型>

1.主键约束 primary key ：保证数据的实体完整性
 
  PRIMARY KEY约束用于定义基本表的主键，它是惟一确定表中每一条记录的标识符，其值不能为NULL，也不能重复，以此来保证实体的完整性。
  
  create table student
  ( sno char(8) not null,   -- primary key,  --第1种方法
    sname char(8),
    ssex char(2),
    sage int,
    sbir datetime,
    constraint pk_stu primary key(sno)     --第2种方法,建议用
  )
   
 create table sc
 ( sno char(8),
   cno char(5),
   score int,
   constraint pk_sc primary key(sno,cno)   --这类表(多个列共同为主键)只能用这种方法
  ) 
  
2.惟一性约束 unique ：保证数据的用户定义完整性

 惟一性约束用于指定一个或者多个列的组合值具有惟一性，以防止在列中输入重复的值。
 
 create table student
  ( sno char(8) not null,   
    sname char(8),---unique,   --第1种方法  
    ssex char(2),
    sage int,
    sbir datetime,
    constraint pk_stu primary key(sno),
    constraint uq_sname unique(sname)     ----第2种方法,建议用   
  )
 
3. 检查约束  check ：保证数据的用户定义完整性
 
 检查约束对输入列或者整个表中的值设置检查条件，以限制输入值，保证数据库数据的完整性。
 
  create table student
  ( sno char(8) not null,      --学号
    sname char(8),             --姓名
    ssex char(2) ,--check(ssex='男' or ssex='女'),  --第1种方法
    sage int check(sage>=17 and sage<=22),
    sbir datetime,
    constraint pk_stu primary key(sno),
    constraint uq_sname unique(sname),     
    constraint ck_ssex check(ssex='男' or ssex='女')    ----第2种方法,建议用   
  )
  
4.空值约束  not(null) ：保证数据的用户定义完整性
  
  空值（NULL）约束用来控制是否允许该字段的值为NULL。NULL值不是0也不是空白，
  更不是填入字符串的“NULL”字符串，而是表示“不知道”、“ 不确定”或“没有数据”的意思。
  
5.默认值约束 default ：保证数据的用户定义完整性
 
 默认约束指定在插入操作中如果没有提供输入值时，则系统自动指定值。
 默认约束可以包括常量、函数、不带变元的内建函数或者空值。
 
 注意：在管理平台的表设计器中，默认值是在“列属性”中设置
 
 create table student
 ( sno char(8) primary key,
   sname char(8),
   ssex char(2),
   sage int,
   sdept varchar(20) default('大数据学院'),     --院系，默认为：大数据学院
   sbir datetime,
   constraint uq_sname unique(sname),
   constraint ck_ssex check(ssex='男' or ssex='女'),
  -- constraint df_sdept default('大数据学院')   --这种方法不行
  ) 

  alter table student
  add constraint df_sdept default('大数据学院') for sdept
  
6.外键约束: foreign key 保证数据的参照完整性
  
  外键 (FOREIGN KEY) 是用于建立和加强两个表数据之间的链接的一列或多列。外部键约束用于强制参照完整性。

   注意：哪个表是外键表，哪个列是外键，跟另外哪个表的哪个列建立联系
   
  create table sc
  (sno char(8),-- foreign key references student(sno),
   cno char(5),
   score int,
   constraint pk_sc primary key(sno,cno),
   constraint fk_sc_stu foreign key(sno) references student(sno)    --sc表中的sno列跟student表中的sno建立外键
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
 
  ALTER TABLE <表名>
[ ADD[COLUMN] <新列名> <数据类型> [ 完整性约束 ] ]
[ ADD <表级完整性约束>]
[ DROP COLUMN  <列名> [CASCADE| RESTRICT] ]
[ DROP [CONSTRAINT]<完整性约束名>[ RESTRICT | CASCADE ] ]
[ALTER COLUMN <列名><数据类型> ] ;

  create table student
( sno char(8) not null,
  sname char(8) ,
  ssex char(2) ,
  sage int,
  sbir datetime
)
  修改表
  当数据库中的表创建完成后，可以根据需要改变表中原先定义的许多选项，以更改表的结构。
  用户可以增加、删除和修改列，增加、删除和修改约束，更改表名以及改变表的所有者等。

  ALTER TABLE <表名>
[ ADD[COLUMN] <新列名> <数据类型> [ 完整性约束 ] ]
[ ADD <表级完整性约束>]
[ DROP [ COLUMN ] <列名> [CASCADE| RESTRICT] ]
[ DROP CONSTRAINT<完整性约束名>[ RESTRICT | CASCADE ] ]
[ALTER COLUMN <列名><数据类型> ] ;

 1.增加列
 --在student表中增加列：spiec(专业)，varchar(20) '计算机科学与技术'
 alter table student
 add spiec varchar(20) default('计算机科学与技术')
 
 alter table student
 add clno char(8) null
 
 2.删除列
 alter table student
 drop column sbir
  
 3.修改列
 --把student表中的sname 的长度修改为16
 alter table student
 alter column sname varchar(16) 
 
 4.增加约束
 alter table student
 add constraint pk_stu primary key(sno)
 
 alter table student
 add constraint ck_ssex check(ssex='男' or ssex='女')
 
 5.删除约束
 alter table student
 drop ck_ssex
 
 6.修改表名
   sp_rename student,stu 
   
 7.删除表
 drop table student
 
 drop table sc
 注意：当2个表建立了联系，我们只能删除外键表，不能删除主键表
 
 
 索引
 
 1.建立索引的目的：加快查询速度
 2.在创建表的 PRIMARY KEY 或 UNIQUE 约束时自动创建索引
 3.创建索引
   CREATE UNIQUE INDEX  Stusno ON Student(Sno);
   CREATE UNIQUE INDEX  Coucno ON Course(Cno);
   CREATE UNIQUE INDEX  SCno ON SC(Sno ASC,Cno DESC);
 4.但不是索引越多越好,因为系统维护这些索引要付出代价，一般情况下不要另外创建索引，用系统自动创建的 PRIMARY KEY 或 UNIQUE 索引


3.4 数据查询

数据查询功能是指根据用户的需要以一种可读的方式从数据库中提取所需数据，
是数据库结构化查询语言SQL的核心内容。 
  
数据查询功能都是通过 SELECT 语句来实现的。SELECT 语句可以从数据库中按照用户的要求检索数据，
    并将查询结果以表格的形式输出。 

  语句格式:
       SELECT [ALL|DISTINCT] <目标列表达式>[,<目标列表达式>] …
       FROM <表名或视图名>[,<表名或视图名> ]…|(SELECT 语句)      
                   [AS]<别名>
      [ WHERE <条件表达式> ]
      [ GROUP BY <列名1> [ HAVING <条件表达式> ] ]
      [ ORDER BY <列名2> [ ASC|DESC ] ];

1.简单查询
   select 列(查询内容)
   from  表
   
 --查询学生的学号，姓名，性别
 select sno,sname,ssex
 from student
 
 select sname,sno,ssex   --查询结果中列的次序跟表中的次序无关，跟 select字句中的列次序一致
 from student
 
 select sno 学号,sname 姓名,ssex as 性别   --给列取别名
 from student
 
 --查询学生的所有信息
 select *           -- * 代表所有列
 from student
 
 --查询学生的学号，姓名，实际年龄
 select sno,sname,year(getdate())-YEAR(sbir) 实际年龄     --查询的内容可以是通过计算得到,显示无列名，可以用别名
 from student
 
 print getdate()   --系统函数,getdate():获取系统当前时间
 print year(getdate())  ----系统函数,year():获取年
       month()
       day()
       
 --查询教师的编号、姓名、教师职称、应发工资
  select tno 编号,tname 姓名,ttitle 教师职称,tjbgz+tgwjt 应发工资
  from teacher
  
  --查询选修了课程的学生的学号
  select distinct sno   --当查询结果中含有重复行时，用 distinct 去掉重复行
  from sc
  
 使用TOP 从句返回指定前面的行
它有两种格式：第一种格式是：“TOP N”，第二种格式是：“TOP N PERCENT”

  --查询学生表中的前5行
  select top 5 *
  from student
  
  select top 5 percent sno,sname,sage
  from student
  
 2.条件查询
 
 当要在表中找出满足某些条件的行时，则需使用 WHERE 子句 指定查询条件
 
 select 子句(列名:查询的内容)
 from 子句(表)
 where 子句(条件表达式)
 
 (1)比较:=, >, <, >=, <=, !=, <>, !>, !<; NOT+
 --查询女同学的学生信息
 select *
 from student
 where ssex='女'
 
 --查询除了选修了课程01001的成绩信息
 select *
 from sc
 where cno<>'01001'
 
 (2)确定范围:  (not) between   and
 
 --查询成绩在80至95的学号、课程号，成绩
 select sno,cno,score
 from sc
 --where score>=80 and score<=95
 where score between 80 and 95
 
 --查询成绩不在80至95的学号、课程号，成绩
 select sno,cno,score
 from sc
 --where score<80 or score>95
 where score not between 80 and 95
 
 (3)确定集合: (not) in(值)
 
 --查询200701，200801班的学生信息
 select *
 from student
 --where clno='200701' or clno='200801'
 where clno in('200701','200801')
 
 --查询除200701，200801班的学生信息
 select *
 from student
 where clno not in('200701','200801')
 
 --查询除01001，01002，02003之外的成绩信息
 select *
 from sc
 where cno not in('01001','01002','02003')
 
 (4)模式匹配: 模糊查询   (not) like 
     与LIKE 关键字配合使用的通配符:  % :包含零个或多个字符的任意字符串
                                   _ :任何单个字符

 --查询课程名中含有'计算机'的课程信息
 select *
 from Course
 where Cname like'%计算机%'
 
 --查询姓赵的学生信息
 select *
 from student
 where sname like'赵%'
 -- where left(sname,1)='赵'
 
 --查询除姓赵的学生信息
 select *
 from student
 where sname not like'赵%'
 
 --查询姓“罗”且全名为三个汉字的学生的姓名。
 select sname
 from student
 where sname like'罗__'
 
 --查询DB_Design课程的课程号和学分。
  SELECT Cno,credits
      FROM     Course
      WHERE  Cname LIKE 'DB\_Design' ESCAPE '\'     --ESCAPE '＼' 表示“ ＼” 为换码字符

 (5)涉及空值的查询: is (not) null
    null
 
 --查询成绩为null的成绩信息
 select *
 from sc
 where score is null
 
 --查询成绩为非null的成绩信息
 select *
 from sc
 where score is not  null
 
 (6)多重条件查询:  and or 
    AND和 OR来连接多个查询条件
    AND的优先级高于OR
    可以用括号改变优先级
 --查询选修01001或01002且分数大于等于85分学生的学号、课程号和成绩。
 select sno,cno,score
 from sc
 where (cno='01001' or cno='01002') and score>=85
 
 (7)重定向输出:INTO
   语法格式：
     INTO new_table

    --查询成绩<60的成绩信息，并以bukao表保存
    select * into bukao
    from sc
    where score<60
 
  --1.查询年龄大于19岁的学生的姓名和年龄。
  select sname,sage
  from Student
  where Sage>19
--2．查询年龄在19岁与22岁(含19岁和22岁)之间的学生的学号、姓名和年龄。
  select sno,sname,sage
  from Student
  where Sage between 19 and 22
--3．查询年龄不在19岁与22岁之间的学生的学号、姓名和年龄。
  select sno,sname,sage
  from Student
  where Sage not between 19 and 22
--4．查询200701、200801班级的学生信息。
   select *
   from Student
   where Clno in('200701','200801')
--5．查询不属于200701、200801班级的学生信息。
    select *
   from Student
   where Clno not in('200701','200801')
--6．查询姓名中含有“良”的学生。
   select *
   from Student
   where Sname like'%良%'
--7．查询选修课程01001或02002，成绩在80至95之间，学号为20080xxx的学生的学号、课程号和成绩。
   select sno,cno,score
   from SC 
   where (Cno in('01001','02002')) and (Score between 80 and 95) and (Sno like'20080___')
--8．查询选修成绩不为空值的选课信息。
   select *
   from SC
   where Score is not null
9--.查询职称为副教授，应发工资大于3000的教师信息。
  select *
  from Teacher 
  where Ttitle='副教授' and (Tjbgz+tgwjt)>3000
  
  
 3.order by 子句:排序查询  
  
  使用 ORDER BY 子句对查询结果进行排序，这样方便查询结果。
   
   order by 列名 asc(升序)[,列名]
   
   ORDER BY 列名1 [ASC | DESC]
                  ……,
            列名n [ASC | DESC]
其中，关键字 ASC 表示按升序排序，DESC 表示按降序排序，默认情况下则按升序排序。

   
   --查询学生的成绩信息，并按课程号升序排序,按成绩的降序排序
   select *
   from sc
   order by cno asc,score desc
   
  --查询全体学生情况，查询结果按所在班的班级编号升序排列，同班级中的学生按年龄降序排列。
  select *
  from student
  order by clno,sage desc

  4.聚合函数:
  
     COUNT(*):统计元组个数

     COUNT([DISTINCT|ALL] <列名>):统计一列中值的个数

     SUM([DISTINCT|ALL] <列名>):计算一列值的总和（此列必须为数值型）	

     AVG([DISTINCT|ALL] <列名>):计算一列值的平均值（此列必须为数值型）

 	 MAX([DISTINCT|ALL] <列名>):求一列中的最大值
 	 
	 MIN([DISTINCT|ALL] <列名>):求一列中的最小值

      聚合函数只能用于下列三种子句中：
     (1)SELECT 语句的选择列表。如SELECT AVG（score）。
     (2)COMPUTE 和 COMPUTE BY 子句。
     (3)HAVING 子句。


  --统计学生表中的学生人数
    select COUNT(*) 人数
    from student
    
    --统计学生表中的女学生人数
    select COUNT(*) 人数
    from student
    where ssex='女'
    
    --统计选修了课程的学生人数
    select COUNT(distinct sno)
    from sc
    
    --查询选修了课程01001的总分，平均分，最高分，最低分
    select SUM(score) 总分,avg(score) 平均分,max(score) 最高分,min(score) 最低分
    from sc
    where cno='01001'
    
  5.分组查询:group by 子句
   语法格式：
    GROUP BY group_by_expression1 [,group_by_expression2][,…]
      
      注意：
          (1)要不要分组，以哪个列来分组
          (2)当条件中含有聚合函数时，不能用 where 子句,而改用 having 子句
          (3) where 子句必须放在 group by 之前，而 having 子句必须放在 group by 子句之后
          (4)所有 SELECT 子句中除聚合函数之外引用的列，也必须出现在 GROUP BY 子句中
      
      
    --分别统计学生表中的男女学生人数
    select ssex,COUNT(*) 人数
    from student
    group by ssex
    
    --查询每个学生选课的总分，平均分，最高分，最低分
    select sno, SUM(score) 总分,avg(score) 平均分,max(score) 最高分,min(score) 最低分
    from sc
    group by sno
    
    --查询每门课程的总分，平均分，最高分，最低分
    select cno, SUM(score) 总分,avg(score) 平均分,max(score) 最高分,min(score) 最低分
    from sc
    group by cno
    
    --查询平均成绩大于等于90分的学生学号和平均成绩                         --
    select sno,avg(score)
    from sc 
    group by sno
    having avg(score)>=90
    
    --查询01001课程的总分，平均分，最高分，最低分
    select cno, SUM(score) 总分,avg(score) 平均分,max(score) 最高分,min(score) 最低分
    from sc
    where cno='01001'
    group by cno
    
    
    --查询学生人数不足4人的班级编号及其相应的学生数。
    select clno,COUNT(*) 学生数
    from student
    group by clno
    having COUNT(*)<4
    
    --查询平均成绩大于等于90分的学生学号，成绩，总分                         --
    select sno,score,sum(score)
    from sc 
    group by sno,score
    having avg(score)>=90
    
    
--1．查询课程01001的最高、最低与平均成绩。
select cno, MAX(score) 最高成绩,MIN(score) 最低成绩,AVG(score) 平均成绩
from SC
where Cno='01001'
group by Cno
--2．查询每个学生选修的课程的总分、平均分，并按学号升序排序。
select sno, SUM(score) 最高成绩,AVG(score) 平均成绩
from SC
group by Sno
order by Sno
--3．查询各部门的教师人数。
select dno,COUNT(*) 教师人数
from Teacher
group by dno

--4．查询学生选修的课程平均分数大于等于70分的课程号、平均成绩。
  select cno,AVG(score)
  from sc
  group by cno
  having AVG(score)>=70

--5．查询各门课程的选修人数，并按人数的升序排序。
  select cno,COUNT(*)
  from sc
  group by cno
  order by COUNT(*) asc

--6．查询学生人数不足4人的班级及其相应的学生数。
   elect clno,COUNT(*) 学生数
    from student
    group by clno
    having COUNT(*)<4
    
--7．查询课程号，成绩，先按课程号升序排序，再按照成绩降序排序。
    select cno,score
    from SC
    order by Cno ,Score desc
--8．统计各职称教师人数。
    select ttitle,COUNT(*) 人数
    from Teacher
    group by Ttitle
--9．查询选修了2门课程以上的学生的学号及其总成绩，查询结果按总成绩降序排序。
    select sno,sum(score) 总成绩,COUNT (*) 课程总数
    from SC
    group by Sno 
    having COUNT(*) >2
    order by SUM(score) desc

 
 
 6.连接查询:实现多个表查询
 连接查询是先将两个表或多个表连接成一个类似于大表格的结果集后，再执行查询
  内连接: inner join   
     (1)两个或两个以上的表的连接条件:表1.列名=表2.列名    如： student.sno=sc.sno
     (2)表的连接条件放在哪个子句:
              a)放在 where 子句中
              b)放在 from 子句中（推荐用）:
                     from  表1 [inner] join 表2 on 连接条件（表1.列名=表2.列名）
                               join 表3 on 表2.列名=表3.列名
                               join 表4 on 表3.列名=表4.列名
     
 --查询学生的学号，姓名，选课的课程号，成绩
 select sc.sno,sname,cno,score
 from student,sc 
 where student.sno=sc.sno
 
  --查询01001或01002且成绩大于85分的的学号，姓名，选课的课程号，课程名，成绩
 select sc.sno,sname,sc.cno,cname,score
 from student,sc,course 
 where student.sno=sc.sno and sc.cno=course.cno and (sc.Cno in('01001','01002')) and score>85

--查询学生的学号，姓名，选课的课程号，课程名，成绩
 select sc.sno,sname,sc.cno,cname,score
 from student join sc  on student.sno=sc.sno
              join Course on sc.cno=course.cno
              
 --查询学生的学号，姓名，班级名称，成绩
 select student.sno,sname,clname,score
 from sc join student on sc.sno=student.sno
         join Class on student.clno=class.clno
         
 --查询学生的学号，姓名，班级名称，成绩
 select s.sno,sname,clname,score
 from sc join student s on sc.sno=s.sno    --给student表取别名 s ,一旦给表取了别名则在整个查询语句中都要用该别名
         join Class c on s.clno=c.clno     --给class表取别名 c
 
         
--1、查询选修了课程01001且成绩在70分以下或成绩在90分以上的学生的姓名、课程名称和成绩。
select sname,cname,score
from Student s join SC on s.Sno=sc.Sno
               join Course c on sc.Cno=c.cno
where sc.Cno='01001' and (Score<70 or Score >90)

--2. 查询所有选了课程的学生学号、姓名和所在班级的班级名称。
select distinct Student.Sno,sname,clname
from SC join Student on sc.Sno=Student.Sno
        join Class on Student.Clno=Class.Clno
--3、查询有学生选修的每门课程的课程号、课程名、平均分数、学分及任课教师姓名，且平均分数大于等于70分。
  select sc.cno,cname,AVG(score),credits,tname
  from sc join course c on sc.cno=c.cno
          join Teaching t1 on c.cno=t1.Cno
          join Teacher t2 on t1.Tno=t2.tno
  group by sc.Cno,cname,credits,tname
  having AVG(score)>=70
  
--4、查询课程号、学分、任课教师、选课成绩总分，并按课程号升序排序。
select sc.Cno,Credits,Tname,SUM(score)总成绩
from SC join Course c on sc.Cno=c.Cno
        join Teaching t1 on c.Cno=t1.Cno
        join Teacher t2 on t1.Tno=t2.tno
group by sc.Cno,Credits,Tname
order by sc.Cno

--5、查询每门课程的课程号、课程名、任课教师、选课数。
select sc.Cno,Cname,Tname,COUNT(sc.Cno)选课数
from SC join course c on sc.cno=c.cno
        join Teaching t1 on c.Cno=t1.Cno
        join Teacher t2 on t1.Tno=t2.tno
group by sc.Cno,cname,Tname



外连接(OUTER join)

左外连接(LEFT OUTER join):在内连接查询的结果基础上，再引用左表剩下的所有行

  select s.*,sc.*
  from student s left outer join sc on s.sno=sc.sno

右外连接(RIGHT OUTER join):在内连接查询的结果基础上，再引用右表剩下的所有行 

  select s.*,sc.*
  from  sc right outer join student s on s.sno=sc.sno
  
  
  7.嵌套查询:子查询
    
    一个 SELECT-FROM-WHERE 语句称为一个查询块
   将一个查询块嵌套在另一个查询块的 WHERE 子句或 HAVING 短语的条件中的查询称为嵌套查询
   注意：
       (1)先执行子查询，然后把子查询的结果作为父查询的条件用
       (2)子查询与父查询连接的方式有两种: 
                      a)当子查询的结果为1个时，用比较运算符连接 =  > < => =< <> !=
                      b)当子查询的结果为多个时，用  (not) in
       (3)子查询的内容(select 目标列)由父查询的条件决定

  --查询年龄最大的学生信息
  select *                --父查询
  from student
  where sage= (select max(sage) from student)    --子查询  
  
  --查询选修了课程的学生信息
  select *
  from student
  where sno in(select distinct sno from sc)
  
  --查询没有选修课程的学生信息
  select *
  from student
  where sno not in(select distinct sno from sc)
  
 --1、查询与 ‘张维明’ 年龄相同的学生的姓名和出生年月。
select sname,year(Sbir) 年,MONTH(sbir) 月
from Student
where Sage=(select Sage from Student where Sname='张维明')
      and Sname!='张维明'
--2、查询选修了“计算机网络”的学生的学号、姓名、成绩。
   select sc.sno,sname,score
   from student join sc on student.sno=sc.sno
   where cno=(select cno from Course where Cname='计算机网络')


--3、查询与 ‘王一夫’ 同班，且年龄大于 ‘赵良明’ 的学生的信息。 
  select *
  from student
  where clno=(select clno from student where sname='王一夫')
        and sage>(select sage from student where sname='赵良明')

--3、查询与 ‘王一夫’ 同班，且年龄大于 ‘赵良明’ 的学生的信息。
select *
from Student
where Clno=(select Clno from Student where Sname='王一夫')
      and Sage>(select Sage from Student where Sname='赵良明')
--4、查询没有选修课程的学生信息。、
select *
from student
where sno not in (select distinct sno from sc)
--5、查询选修了课程“01001”并且与‘关鹏’同班的学生信息。
select *
from Student join SC on Student.Sno=SC.Sno
where Cno='01001'
      and Clno =(select Clno from Student where Sname='关鹏')
      
  select *
  from Student 
  where sno in(select sno from sc where Cno='01001')
      and Clno =(select Clno from Student where Sname='关鹏')
          
--6、查询与李闲教师职称相同并且基本工资大于‘王大有’的教师号、姓名、职称和基本工资。
select tno,tname,ttitle,tjbgz
from Teacher 
where Ttitle =(select Ttitle from Teacher where Tname='李闲')
      and Tjbgz>(select Tjbgz from teacher where Tname ='王大有')
  
  
  3.5 数据更新
 
   1.插入数据:
   语句格式:
	insert into <表名> [(<属性列1>[,<属性列2 >…)]
	VALUES (<常量1> [,<常量2>]… );   --只能插入一条数据
   功能:
    将新元组插入指定表中
    
    注意：(1)若给出的常量值只是表的部分列值，必须在表名后给出对应的部分列名(不能缺省为非 null 的列)
    
    --插入一条成绩信息：20070101，02001，90
    insert into sc
    values('20070101','02001',90)
    
    insert into student(sno,clno,sname) 
    values('2021001','201001','刘丽')
    
    insert into student(sno,sname) 
    values('2021002','李玉')


    语句格式:
    INSERT INTO <表名>  [(<属性列1> [,<属性列2>…  )]
 	子查询;     --把子查询的多条数据插入到表中,表必须是存在
 	
 	
 	select * into stu
 	from student 
 	where ssex='男'
 	
 	  insert into stu
 	  select *
 	  from student
 	  where ssex='女'
 	  
  2.修改数据
   语句格式:
    UPDATE  <表名>
    SET  <列名>=<表达式>[,<列名>=<表达式>]…
    [WHERE <条件>];
    
    --把计算机网络的学分修改成5分
    update Course
    set credits=5
    where Cname='计算机网络'
    
    --将Student表中‘关鹏’同学的姓名修改为‘关红’，并且性别改为女。
    update student 
    set sname='关红' , ssex='女'
    where sname='关鹏'
    
   -- 将Course表中‘C语言程序设计 ’学分数修改成与‘数据库原理及应用’的学分数相同。
   update Course
   set Credits=(select Credits from Course where Cname='数据库原理及应用')
   where cname='C语言程序设计'

  3.删除数据
   语句格式:
       delete from   <表名>
       [WHERE <条件>];
功能:删除指定表中满足WHERE子句条件的元组

--删除SC表中学号为‘20070101’的成绩信息。
  delete from sc
  where Sno='20070101'
 
  
  
  
  3.7 视图
  
  1.视图的概念：
    视图是个虚表，是从一个或者多个表或视图中导出的表，其结构和数据是建立在对表的查询基础上的，
     并不表示任何物理数据，而只是用来查看数据的窗口而已。
  (1)虚表，是从一个或几个基本表（或视图）导出的表
  (2)只存放视图的定义，不存放视图对应的数据
  (3)基表中的数据发生变化，从视图中查询出的数据也随之改变
   
 2.创建视图
   语句格式:
      create view  <视图名>  [(<列名>  [,<列名>]…)]
       AS  <子查询>
   
   create view view1
   as
    select s.sno,sname,sc.cno,cname,score,credits
    from student s join sc on s.sno=sc.sno
                   join Course c on sc.cno=c.cno
       
   --创建视图view2:sno,clname,cno,score
    create view view2
    as
      select s.sno,clname,cno,score
         from sc join student s on sc.sno=s.sno
                 join Class c on s.clno=c.clno
                 
                 
   --创建视图view3:  sno,sname,clname,cno,cname,score,credits  
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
   
   3.视图的作用 :安全性
   (1)通过视图查询数据
     select sno,sname,cno,score,credits
     from view1
     
    (2)通过视图向基本表中插入数据
    
    insert into view5(sno,clno,sname)     --向视图view5中插入一条数据，同时在基本表student中也插入相同一条数据
    values('20070105','200701','陈宇')
    
    
    --建立一个Tea_view1的教师视图，输出Tno、Tname、Tsex，再通过视图插入一条教师信息 .
    create view Tea_view1
    as 
      select tno,tname,tsex
      from Teacher
      
    insert into Tea_view1
    values('02007','李玉','女') 
    
    (2)通过视图修改基本表中数据
     
    --在sc上建立一个sc_view2的学生视图，再通过该视图把所有01001的课程成绩增加5分。
    create view sc_view2
    as
     select *
     from sc
     
     update sc_view2     --修改视图sc_view2中的数据，同时在基本表sc中也修改了相同数据 
     set score=score+5
     where cno='01001'
    
    (3)通过视图删除基本表中数据
    
    delete from view5
    where sno='20070103'
    
         create VIEW S_G(Sno,Gavg)
             AS  
             SELECT Sno,AVG(score)
             FROM  SC
             GROUP BY Sno;


  --1、创建显示学号、姓名、课程编号、成绩的视图sc_view1，并通过该视图sc_view1向SC表插入一条数据。
create view sc_view1
as 
  select SC.sno,Sname,Cno,Score 
  from Student join SC on Student.Sno=SC.sno

insert into sc_view1(Sno,Sname,Cno,Score)
values('2001003','张力','01001','95')
原因：视图或函数 'sc_view1' 不可更新，因为修改会影响多个基表。

--2、建立一个Tea_view1的教师视图，输出Tno、Tname、Tsex，再通过视图插入一条教师信息 .
create view Tea_view1
as 
  select tno,tname,tsex
  from teacher
  
  insert into Tea_view1
  values('02009','陈飞宇','男')

--3、在sc上建立一个sc_view2的学生视图，再通过该视图把所有01001的课程成绩增加5分。
  create view sc_view2
  as 
   select *
   from SC
   
  update sc_view2
  set Score=Score+5
  where Cno='01001'
--4、在老师信息表Teacher上建立一个Tea_view2的教师视图，再通过视图插入一条教师信息('02005','李明','男',1981-09-28,'讲师','0003',1800,780)。
  create view Tea_view2
  as
  select * 
  from Teacher
  
  insert
  into Tea_view2
  values('02005','李明','男','1981-09-28','讲师','0003',1800,780)
--5、在老师信息表Teacher上建立一个Tea_view4的教师视图，再通过视图把所有副教授的基本工资（Tjbgz）上调500元。。
  create view Tea_view4
  as
  select *
  from Teacher
  
  update Tea_view4
  set Tjbgz=Tjbgz+500
  where Ttitle='副教授'
--6、在老师信息表Teacher上建立一个Tea_view6的教师视图，再通过视图把所有职称是讲师的教师删除。
  create view Tea_view6
  as
  select *
  from Teacher
  
  delete from Tea_view6
  where Ttitle='讲师' 
   
    
    --7.在老师信息表Teacher上建立一个职称是副教授、基本工资大于等2000元的教师视图view_teacher。并通过视图view_teache：
    --①往教师表里插入一条记录；②删除姓“王”的教师；③把年龄大于等于35的教师的基本工资上调300元。
    create view view_teacher 
    as
     select *
     from Teacher
     where Ttitle='副教授' and Tjbgz>=2000
    
    
     insert into view_teacher(Tno,tname)
     values('02008','陈虎')
     
     delete from view_teacher
     where Tname  like'王%'
     
     update view_teacher
     set Tjbgz=Tjbgz+300
     where (year(GETDATE())-YEAR(tbir))>=35
   
   
  
  第8章 数据库编程
 
  1.变量:
   从变量的作用范围来区分，SQL Server提供两种形式的变量：局部变量和全局变量。
   全局变量:由系统定义并维护，通过在名称前面加“@@”符号
   局部变量:的首字母为单个“@”
   
   (1)定义变量
   使用DECLARE语句声明局部变量
  格式：DECLARE @<变量名> <变量类型>[,@<变量名> <变量类型>]...
   局部变量的作用域是在其中声明局部变量的批处理、存储过程或语句块
   
   declare @sno char(8),@num int
   
   (2)局部变量赋值

  方法一:使用 SET 语句
   如：set @cname = '计算机网络'

  方法二:使用 SELECT 语句 
   如：select  @cname = '计算机网络'
       select @num =COUNT(*) FROM Student    --select既实现查询，又实现把查询的结果赋给局部变量 
       
     
  (3)读取(输出)变量的值

 方法一:使用 SELECT 语句:以表格形式输出
   如：select  @cname

 方法二:使用PRINT语句:以文本形式输出
     如：print @cname


  declare @num int 
  select @num =COUNT(*) FROM Student
  select @num 人数
  print @num
  
  --创建@cname 和@num变量，然后将课程编号为01001的课程名放在@cname变量中，把选课人数放在@num变量，
  --最后输出 @cname变量和@num变量的值。
  declare @cname char(20),@num int
  select @cname=cname,@num=COUNT(*) 
  from  sc join Course on sc.cno=course.cno 
  where sc.Cno='01001'
  group by sc.cno,cname
  select @cname 课程名,@num 选课人数
  
  SELECT getdate( )  AS  '当前的时期和时间', 
         @@connections AS  '试图登录的次数'


  2.流程控制语句
  
  (1)选择控制 IF…ELSE 语句
  IF...ELSE 的语法格式为：
  IF Boolean_expression
    { sql_statement | statement_block } --条件表达式为真时执行
  [ ELSE
    { sql_statement | statement_block } ] --条件表达式为假时执行
  
  
  --用EXISTS确定表student中是否存在某个同学。
  
   DECLARE @name varchar(40),@msg varchar(255)
   SELECT @name='关鹏'
   IF EXISTS(SELECT * FROM student WHERE sname=@name)
      BEGIN
         SELECT @msg='有人名为'+@name
         SELECT @msg
      END
   ELSE
      BEGIN
         SELECT @msg='没有人名为'+@name
         SELECT @msg
      END
      
      
 (2)选择控制 CASE 语句 
 
 CASE 函数：计算多个条件并为每个条件返回单个值。
 
  (a) 简单 CASE 函数：将某个表达式与一组简单表达式进行比较以确定结果。
    CASE input_expression
       WHEN when_expression THEN result_expression
       [ ...n ]
       [ELSE else_result_expression ]
    END
    
    --查询教师的编号，姓名，性别，职称，职称类别：教授或副教授为高级职称，讲师为中级职称，否则为低级职称
    select tno,tname,tsex,ttitle,
         case ttitle
             when '教授' then '高级职称'
             when '副教授' then '高级职称'
             when '讲师' then '中级职称'
             else '低级职称'
         end 职称类别
    from teacher




 (b) CASE 搜索函数：CASE 计算一组逻辑表达式以确定结果。
    CASE   
      WHEN Boolean_expression THEN result_expression
         [ ... n ]
         [ ELSE else_result_expression ]
      END

  --查询学生的学号，姓名，课程号，课程名，成绩，成绩等级：>=90,则优秀，>=80,则良好；>=70,则中等；>=60，则及格；否则为不及格
   select s.sno,sname,sc.cno,cname,score,
       case    
           when score>=90 then '优秀'
           when score>=80 then '良好'
           when score>=70 then '中等'
           when score>=60 then '及格'
           else '不及格'
       end  成绩等级
  from student s join sc on s.sno=sc.sno
                 join course c on sc.cno=c.cno


(3)循环控制 WHILE 语句
  
   --从1加到100的值
   declare @i int,@sum int
   set @i=1
   set @sum=0
   while @i<=100
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   PRINT  '1+2+…+100='+CAST(@sum  AS  char(25))   --case()为系统函数：对局部变量进行类型转换

 
 (4)跳转语句 GOTO
 
  使用GOTO语句可以使SQL语句的执行流程无条件地转移到指定的标号位置
   Label:
     ……
    GOTO label
    
    --从1加到100的值
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
   PRINT  '1+2+…+100='+CAST(@sum  AS  char(25))
   
  (5)RETURN 语句 
    RETURN 语句可使程序从批处理、存储过程或触发器中无条件退出，不再执行本语句之后的任何语句。
    
   
  (6)调度执行语句 WAITFOR 
    使用 WAITFOR 语句可以在某一个时刻或某一个时间间隔后执行SQL语句或语句组。
    WAITFOR 语句允许开发者定义一个时间，或者一个时间间隔，在定义的时间内或者经过定义的时间间隔时，其后的Transact-SQL语句会被执行。
    WAITFOR 语句格式如下：
     WAITFOR {DELAY 'time'|TIME 'time'} 

     waitfor delay '00:00:05'
     select * from student
     
      waitfor time '15:36:00'
      select * from student
     
    
  --8、判断是否有教师的岗位津贴少于1200，若有则将所有教师的岗位津贴增加100，直到所有教师的岗位津贴都在1200以上。
   while exists(select * from teacher where Tgwjt<1200)
       update Teacher 
       set Tgwjt=Tgwjt+100
       
 --1、声明两个整形的局部变量：@a1和@a2，并给@a1赋初值10，给@a2赋值@a1*5，再显示@a2的结果。
declare @a1 int,@a2 int 
--select @a1=10,@a2=@a1*5
set @a1=10
set @a2=@a1*5
print @a2
--2、用EXISTS确定表Student中是否存在“赵丽丽”。若存在则打印“Student表中有学生人名为：赵丽丽同学”，否则打印“Student表中不存在学生人名为：赵丽丽同学”。
declare @name varchar(20),@msg varchar(255)
select @name='赵丽丽'
if exists(select* from Student where Sname=@name)
   begin
      select @msg='有人名为'+@name
      select @msg
   begin
   end
else
   begin
      select @msg='没有人名为'+@name
      select @msg
   end
--3、使用while语句实现计算5000减1、减2、减3、…一直减到50的结果，并显示最终结果
declare @i int,@sum int
set @i=1
set @sum=5000
while @i<=50
begin
set @sum=@sum-@i
set @i=@i+1
end
print @sum


--4、根据输入的教师编号，返回该教师编号对应教师的姓名、性别、出生年月及职称。
DECLARE @Tno varchar(40)
select @Tno='01001'
if exists(select * from Teacher where Tno=@Tno)
   begin
   select Tname,Tsex,year(Tbir),month(Tbir),Ttitle
   from Teacher 
   where Tno=@Tno  
   end 
   
--5、显示所有同学的学号、姓名和系别类型，系别类型分为文科系和理科系，其中数学系、计算机系、电子与信息工程系属于理科系，其余属于文科系。
 select sno,sname,
   case dname
    when '数学系 '  then'理科系'
    when '计算机系' then '理科系'
    
    when '电子与信息工程系' then '理科系'
    else '文科系'
   end
 from student s join class c on s.clno=c.clno
               join department d on c.dno=d.dno




--6、查询学生的学号，姓名，班级，选修课程名及其成绩，并把成绩转换成‘A’（>=90）、‘B’ （>=80）、 ‘C’ （>=70）、 ‘D’ （>=60） ‘E’ （<60）等级。
select s.sno,sname,clno,cname,score,
    case 
    when score>=90 then 'A'
    when score>=80 then 'B'
    when score>=70then 'C'
    when score>=60then 'D'
    else '不合格'
    end 等级
    from Student s join sc on s.Sno=sc.Sno
                   join Course c on sc.Cno=c.cno
    

--7、利用goto语句求出从1加到100的总和。
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



--8、判断是否有教师的岗位津贴少于800，若有则将所有教师的岗位津贴增加100，直到所有教师的岗位津贴都在800以上。
if exists(select* from Teacher where Tgwjt<800)
update Teacher
set Tgwjt=Tgwjt+100





--9、声明变量@x, @y为整型，如果@x>@y，程序终止执行，否则程序等待10秒钟，查询学生信息，
--并且程序在'17:20'时间点并保存到stu_info表。
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

  
 8.2 存储过程
  
  1.存储过程的概念
    存储过程是为完成特定的功能而汇集在一起的一组SQL程序语句，经编译后存储在数据库中的SQL程序
    
   2. 创建存储过程
   
    CREATE  PROCEDURE  存储名
       [@参数名  数据类型][OUTPUT]
        AS  
          SQL语句(功能语句)

   说明：
① 只能在当前数据库中创建存储过程。
② 若带OUTPUT选项，则参数为输出参数，执行存储过程时后面也要加OUTPUT；若缺省，则为输入参数。
③ 输出参数的功能：把存储过程中的数据传输到外部。
④ 输入参数的功能：把的外部数据传输到存储过程中。



    EXECUTE  存储过程名
   [实参数[，OUTPUT][，…]


  --创建存储过程p1:从1加到100的值 
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
   PRINT  '1+2+…+100='+CAST(@sum  AS  char(25))
   
   execute p1
   
   --创建存储过程p2：查询选修了“高等数学”课程学生的考试情况，列出学生的姓名、课程名和考试成绩
   create proc p2
   as
     select sname,cname,score
     from student s join sc on s.sno=sc.sno
                    join Course c on sc.cno=c.Cno
     where Cname='高等数学'
     
   exec p2 
   
   --创建存储过程p3:从1加到指定值的值  
  create proc p3
  @n int      --1个输入参数
  as 
   declare @i int,@sum int
   set @i=1
   set @sum=0
   while @i<=@n
      begin
        set @sum=@sum+@i
        set @i=@i+1
      end
   PRINT  '1+2+…+@n='+CAST(@sum  AS  char(25))
   
   exec p3 245
   
  创建存储过程p4:查询某个学生某门课程的考试成绩，若没有指定课程，则默认课程为“大学物理”。 
  create proc p4
  @sno char(8),
  @cname char(20)='大学物理'
  as
    select sno,sc.cno,cname,score
    from sc join Course c on sc.cno=c.Cno
    where sno=@sno and Cname=@cname
  
  exec p4 '20080101'
  exec p4 '20080101','高等数学'      --按位置传递值：必须一一对应
  exec p4 @cname='C语言程序设计',@sno='20070101'    --按参数名传递
   
 创建存储过程p5:--查询指定班号、指定性别的学生中年龄大于等于指定年龄的学生的情况。
 --班号的默认值为“200801”，默认性别为“男”，默认的年龄为20。
 create proc p5
 @clno char(8)='200801',
 @ssex char(2)='男',
 @sage int=20
  as
    select *
    from student
    where clno=@clno and ssex=@ssex and sage>=@sage 
   
  exec p5
  exec p5 '200701' 
  exec p5 @ssex='女'
  exec p5 @ssex='女',@sage=25
   
 --1、创建查询每个学生的选修课程总学分的存储过程p1，要求列出学号和总学分。并执行此存储过程。
create proc p1
as
  select sno,SUM(score)
  from sc
  group by sno

exec p1  
--2、创建查询学生的学号、姓名、课程号、课程名、课程学分的存储过程p2，将学生所在的系作为输入参数，
--执行此存储过程，并分别指定一些不同的输入参数执行此存储过程。
create proc p2
@dno char(20)
as
  select s.sno,sname,sc.cno,cname,credits
  from class c1 join Student s on c1.Clno=s.clno
                join sc on s.Sno=sc.Sno
                join Course c on sc.Cno=c.Cno
  where dno=@dno    
 
 exec p2 '0001'            
--3、创建计算1+2+3……..一直加到指定值的存储过程p3，要求：计算的终值由输入参数决定，计算结果由输出参数返回给调用者。并执行此存储过程。
--4、创建修改指定课程的学分的存储过程p4，输入参数为：课程号和修改后的学分，修改后的学分默认值为3。并执行此存储过程。
create proc p4
@cno char(8),
@credits int=3
as
  update Course
  set Credits=@credits
  where Cno=@cno

exec p4 '01001'
exec p4 '01001',4
--5、创建查询学生的学号、姓名、课程名、课程学分、选课成绩的存储过程p5，将学生姓名作为输入参数，执行此存储过程。
create proc p5
@sname char(8)
as
  select s.sno,sname,cname,credits,score
  from Student s join sc on s.Sno=sc.Sno
                 join Course c on sc.Cno=c.Cno
  where Sname=@sname
  
  exec p5 '赵良明'
--6、创建存储过程p6：输入一个学生的学号，通过输出参数返回该学生的姓名和平均分。并执行此存储过程。
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
  select @sname 姓名,@avg 平均分
  
  
--7、创建一个存储过程p7删除course表个指定课程号的记录。并执行此存储过程。
create proc p7
@cno char(8)
as
  delete from Course
  where Cno=@cno 
  
  exec p7 '02004'
--8、创建存储过程p8，查询指定班号、指定性别的学生中年龄大于等于指定年龄的学生的情况。班号的默认值为“200801”，默认性别为“男”，默认的年龄为20。并执行此存储过程。
--9.修改存储过程p6，使之输入课程号，通过输出参数返回该课程的课程名、学分及任课教师姓名。并执行此存储过程。
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

--10.删除存储过程p1,p2,p9。
  drop proc p1,p2,p9
 
   
 第5章 触发器
 
 1.触发器的概念
 
   触发器是一种特殊类型的存储过程
   触发器主要是通过事件进行触发而被执行的，而存储过程可以通过过程名字直接调用。
   当对某一表进行 UPDATE、INSERT、DELETE 操作时，SQL Server 就会自动执行触发器所定义的SQL语句，从而确保对数据的处理必须符合由这些SQL语句所定义的规则。
  触发器的主要作用就是能够实现由主键和外键所不能保证的参照完整性和数据的一致性。

2.创建触发器

  create trigger 触发器名
  on 表名
  for 事件
  as
     SQL 语句
     
     
  --创建触发器tr1:当有学生被删除时，提示“删除成功，有学生退学”   
  create trigger tr1
  on student
  for delete
  as
    --print'删除成功，有学生退学'
    select * from deleted
    DECLARE @msg varchar(50)
   SELECT @msg=STR(@@ROWCOUNT)+'个学生退学'
   SELECT @msg
   RETURN
    
    
  delete from student
  where clno='200802'
  
 在触发器的执行过程中，SQL Server 建立和管理两个临时的虚拟表：Deleted表和Inserted表。
 这两个表包含了在激发触发器的操作中插入或删除的所有记录。
  Deleted表:在执行 DELETE 或 UPDATE 语句时，从触发程序表中被删除的行
  Inserted表:在执行 INSERT 或 UPDATE 语句之后所有被添加或被更新的行
  
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
  
  创建触发器tr4:对sc表实现限制最低成绩必须大于等于0。
  create trigger tr4
  on sc
  for insert,update
  as
    select * from inserted 
    if  exists(select * from inserted where score<0)
    begin
      rollback   --事务回滚,撤销
      print'成绩必须大于等于0'
    end 
     
     
  insert into sc
  values('20080104','01002',-90)
  
  创建触发器tr5:在SC表中定义一个限制学生选课门数不能超过5门。
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
      rollback   --事务回滚,撤销
      print'选课门数不能超过5门'
    end 
      
      
  insert into sc
  values('20080104','03003',90)
  
 drop trigger tr1,tr2,tr3,tr4,tr5 
 
 
--1、建立一个触发器，当向Student表中添加数据时，如果添加的学生的年龄不在12岁～60岁之间，则将禁止插入此学生。
 create trigger tr1
 on student
 for insert
 as
    select * from inserted 
    if  exists(select * from inserted where sage not between 12 and 60)
    begin
      rollback   
      print'年龄必须在12岁～60岁之间'
    end  
  
  insert into student(sno,clno,sname,ssex,sage) 
  values('20080105','200801','罗玉','女',10)
   
--2、建立一个触发器，当删除Teacher表中的教师信息时，如果要删除的教师的职称是副高以上，则将禁止删除此教师。
create trigger tr2
on teacher 
for delete
as
  if  exists(select * from deleted where Ttitle='教授' or Ttitle='副教授')
    begin
      rollback   
      print'禁止删除职称是副高以上的教师'
    end 
    
  delete from Teacher
  where Tno='01004' 
   
--3、在SC表中定义一个更新和插入触发器，在此触发器中保证成绩在0~100范围内。
  create trigger tr3
  on sc
  for insert,update
  as
    if  exists(select * from inserted where score not between 0 and 100)
    begin
      rollback   --事务回滚,撤销
      print'成绩必须在0~100范围内'
    end 
     
     
  insert into sc
  values('20080104','01002',-90)
--4、建立一个触发器，当修改Teacher表中职称为讲师的教师的基本工资时，如果修改的值大于1700，则不能修改此教师的基本工资。
  create trigger tr4
  on teacher
  for update
  as
    if  exists(select * from inserted where Ttitle='讲师' and Tjbgz>1700)
    begin
      rollback   --事务回滚,撤销
      print'职称为讲师的教师的基本工资不能大于1700'
    end 
    
    update Teacher
    set Tjbgz=1800
    where Tno='02002'
--5、为SC建立一个insert触发器，当SC中插入的记录中的学号是student表中没有的学号，则提示“不能插入该记录”，否则提示记录插入成功。
   create trigger tr5
   on sc
   for insert
   as
    declare @sno char(8)
    select @sno=sno from inserted
    if exists(select * from student where sno!=@sno)
      begin
        rollback   
        print'学生表中不存在该同学，不能不能插入该记录'
      end 
    else
      print'记录插入成功'
      
   insert into sc
  values('20080105','02001',90)
      
--6、在COURSE表上定义一个限制删除有学生选修的课程的触发器。
  create trigger tr6
  on course
  for delete
  as
    declare @cno char(8)
    select @cno=cno from deleted
    if exists(select * from sc where cno=@cno)
      begin
        rollback   
        print'不能删除该课程，因为有学生选修了该课程'
      end 
    
  delete from Course
  where Cno='01001'  
    
   
 