--------------------------------------------------------
--  DROP Tables
--------------------------------------------------------
DROP TABLE ACTIVITY cascade constraints PURGE;
DROP TABLE VOLUNTEER_WORK cascade constraints PURGE;
DROP TABLE STUDENT_GUARDIAN cascade constraints PURGE;
DROP TABLE STUDENT_EXAM cascade constraints PURGE;
DROP TABLE STUDENT cascade constraints PURGE;
DROP TABLE SCHOOL_ATTEND cascade constraints PURGE;
DROP TABLE SCHOOL_APPLY cascade constraints PURGE;
DROP TABLE GUARDIAN cascade constraints PURGE;
DROP TABLE SCHOOL cascade constraints PURGE;
DROP TABLE EXAM cascade constraints PURGE;
--------------------------------------------------------
--  DDL for Table STUDENT
--------------------------------------------------------

  CREATE TABLE STUDENT 
   (	STUDENT_ID NUMBER(38), 
      FIRST_NAME VARCHAR2(255), 
      LAST_NAME VARCHAR2(255), 
      SSN CHAR(9), 
      GENDER CHAR(1), 
      STREET_ADDR VARCHAR2(255), 
      STREET_ADDR2 VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      ZIP CHAR(5), 
      PHONE CHAR(10), 
      GRADE_LEVEL NUMBER(38), 
      ENROLL_DATE DATE, 
      END_DATE DATE, 
      END_REASON VARCHAR2(255), 
      COMMENTS VARCHAR2(255),
      UNIQUE(SSN),
      CONSTRAINT STUDENT_PK PRIMARY KEY (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table GUARDIAN
--------------------------------------------------------

  CREATE TABLE GUARDIAN 
   (	GUARDIAN_ID NUMBER(38), 
      FIRST_NAME VARCHAR2(255), 
      LAST_NAME VARCHAR2(255), 
      STREET_ADDR VARCHAR2(255), 
      STREET_ADDR2 VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      ZIP CHAR(5), 
      PHONE CHAR(10),
      CONSTRAINT GUARDIAN_PK PRIMARY KEY (GUARDIAN_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table SCHOOL
--------------------------------------------------------

  CREATE TABLE SCHOOL 
   (	SCHOOL_ID NUMBER(38), 
      NAME VARCHAR2(255), 
      CITY VARCHAR2(255), 
      STATE CHAR(2), 
      TYPE CHAR(1),
      CONSTRAINT SCHOOL_PK PRIMARY KEY (SCHOOL_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table EXAM
--------------------------------------------------------

  CREATE TABLE EXAM 
   (	EXAM_ID NUMBER(38), 
      NAME VARCHAR2(50), 
      ABBR VARCHAR2(10), 
      EXAM_LEVEL CHAR(1),
      CONSTRAINT EXAM_PK PRIMARY KEY (EXAM_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table ACTIVITY
--------------------------------------------------------

  CREATE TABLE ACTIVITY 
   (	STUDENT_ID NUMBER(38), 
      ACTIVITY_ID NUMBER(38), 
      DESCRIPTION VARCHAR2(255), 
      START_DATE DATE, 
      END_DATE DATE, 
      COMMENTS VARCHAR2(255),
      CONSTRAINT ACTIVITY_PK PRIMARY KEY (STUDENT_ID, ACTIVITY_ID),
      CONSTRAINT FK_ACTIVITY_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table VOLUNTEER_WORK
--------------------------------------------------------

  CREATE TABLE VOLUNTEER_WORK 
   (	STUDENT_ID NUMBER(38), 
      VOLUNTEER_WORK_ID NUMBER(38), 
      DESCRIPTION VARCHAR2(255), 
      START_DATE DATE, 
      END_DATE DATE, 
      ASSIGNED_BY VARCHAR2(255), 
      COMMENTS CLOB,
      CONSTRAINT VOLUNTEER_WORK_PK PRIMARY KEY (STUDENT_ID, VOLUNTEER_WORK_ID),
      CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table STUDENT_GUARDIAN
--------------------------------------------------------

  CREATE TABLE STUDENT_GUARDIAN 
   (	STUDENT_ID NUMBER(38), 
      GUARDIAN_ID NUMBER(38), 
      RELATION VARCHAR2(255),
      CONSTRAINT STUDENT_GUARDIAN_PK PRIMARY KEY (STUDENT_ID, GUARDIAN_ID),
      CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID),
      CONSTRAINT FK_STUDENT_GUARDIAN_G_ID FOREIGN KEY (GUARDIAN_ID)
        REFERENCES GUARDIAN (GUARDIAN_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table STUDENT_EXAM
--------------------------------------------------------

  CREATE TABLE STUDENT_EXAM 
   (	STUDENT_ID NUMBER(38), 
      EXAM_ID NUMBER(38), 
      TEST_DATE DATE, 
      SCORE NUMBER(38),
      CONSTRAINT STUDENT_EXAM_PK PRIMARY KEY (STUDENT_ID, EXAM_ID, TEST_DATE),
      CONSTRAINT FK_STUDENT_EXAM_EXAM_ID FOREIGN KEY (EXAM_ID)
        REFERENCES EXAM (EXAM_ID),
      CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/

--------------------------------------------------------
--  DDL for Table SCHOOL_ATTEND
--------------------------------------------------------

  CREATE TABLE SCHOOL_ATTEND 
   (	STUDENT_ID NUMBER(38), 
      SCHOOL_ID NUMBER(38), 
      ENROLL_DATE DATE, 
      END_DATE DATE, 
      END_REASON VARCHAR2(255),
      CONSTRAINT SCHOOL_ATTEND_PK PRIMARY KEY (STUDENT_ID, SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID FOREIGN KEY (SCHOOL_ID)
        REFERENCES SCHOOL (SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/
--------------------------------------------------------
--  DDL for Table SCHOOL_APPLY
--------------------------------------------------------

  CREATE TABLE SCHOOL_APPLY 
   (	STUDENT_ID NUMBER(38), 
      SCHOOL_ID NUMBER(38), 
      DECISION VARCHAR2(255),
      CONSTRAINT SCHOOL_APPLY_PK PRIMARY KEY (STUDENT_ID, SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID FOREIGN KEY (SCHOOL_ID)
        REFERENCES SCHOOL (SCHOOL_ID),
      CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID FOREIGN KEY (STUDENT_ID)
        REFERENCES STUDENT (STUDENT_ID)
   ) ;
/

  ALTER TABLE ACTIVITY DISABLE CONSTRAINT FK_ACTIVITY_STUDENT_ID;
  ALTER TABLE VOLUNTEER_WORK DISABLE CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN DISABLE CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN DISABLE CONSTRAINT FK_STUDENT_GUARDIAN_G_ID;
  ALTER TABLE STUDENT_EXAM DISABLE CONSTRAINT FK_STUDENT_EXAM_EXAM_ID;
  ALTER TABLE STUDENT_EXAM DISABLE CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID;
  ALTER TABLE SCHOOL_ATTEND DISABLE CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID;
  ALTER TABLE SCHOOL_ATTEND DISABLE CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID;
  ALTER TABLE SCHOOL_APPLY DISABLE CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID;
  ALTER TABLE SCHOOL_APPLY DISABLE CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID;
/

  INSERT INTO ACTIVITY SELECT * FROM ACADEMY_PREP.ACTIVITY;
  INSERT INTO EXAM SELECT * FROM ACADEMY_PREP.EXAM;
  INSERT INTO GUARDIAN SELECT * FROM ACADEMY_PREP.GUARDIAN;
  INSERT INTO SCHOOL SELECT * FROM ACADEMY_PREP.SCHOOL;
  INSERT INTO SCHOOL_APPLY SELECT * FROM ACADEMY_PREP.SCHOOL_APPLY;
  INSERT INTO SCHOOL_ATTEND SELECT * FROM ACADEMY_PREP.SCHOOL_ATTEND;
  INSERT INTO STUDENT SELECT * FROM ACADEMY_PREP.STUDENT;
  INSERT INTO STUDENT_EXAM SELECT * FROM ACADEMY_PREP.STUDENT_EXAM;
  INSERT INTO STUDENT_GUARDIAN SELECT * FROM ACADEMY_PREP.STUDENT_GUARDIAN;
  INSERT INTO VOLUNTEER_WORK SELECT * FROM ACADEMY_PREP.VOLUNTEER_WORK;
/
  ALTER TABLE ACTIVITY ENABLE CONSTRAINT FK_ACTIVITY_STUDENT_ID;
  ALTER TABLE VOLUNTEER_WORK ENABLE CONSTRAINT FK_VOLUNTEER_WORK_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN ENABLE CONSTRAINT FK_STUDENT_GUARDIAN_STUDENT_ID;
  ALTER TABLE STUDENT_GUARDIAN ENABLE CONSTRAINT FK_STUDENT_GUARDIAN_G_ID;
  ALTER TABLE STUDENT_EXAM ENABLE CONSTRAINT FK_STUDENT_EXAM_EXAM_ID;
  ALTER TABLE STUDENT_EXAM ENABLE CONSTRAINT FK_STUDENT_EXAM_STUDENT_ID;
  ALTER TABLE SCHOOL_ATTEND ENABLE CONSTRAINT FK_SCHOOL_ATTEND_SCHOOL_ID;
  ALTER TABLE SCHOOL_ATTEND ENABLE CONSTRAINT FK_SCHOOL_ATTEND_STUDENT_ID;
  ALTER TABLE SCHOOL_APPLY ENABLE CONSTRAINT FK_SCHOOL_APPLY_SCHOOL_ID;
  ALTER TABLE SCHOOL_APPLY ENABLE CONSTRAINT FK_SCHOOL_APPLY_STUDENT_ID;
/