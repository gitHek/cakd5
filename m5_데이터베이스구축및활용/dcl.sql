--DCL

-- 사용자 생성
CREATE USER C##TEST1
IDENTIFIED BY TEST1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

--권한 부여
GRANT CONNECT, RESOURCE TO C##TEST1;
GRANT CREATE VIEW, CREATE SYNONYM TO C##TEST1;
GRANT UNLIMITED TABLESPACE TO C##TEST1;

--권한 회수
REVOKE CONNECT, RESOURCE FROM C##TEST1;
REVOKE CREATE VIEW, CREATE SYNONYM FROM C##TEST1;
REVOKE UNLIMITED TABLESPACE FROM C##TEST1;

--사용자 삭제
DROP USER C##TEST1;

-- 사용자 생성, Tablespace 지정 및 권한부여를 일괄 수행

CREATE USER C##TEST1
IDENTIFIED BY TEST1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO C##TEST1;
GRANT CREATE VIEW, CREATE SYNONYM TO C##TEST1;
GRANT UNLIMITED TABLESPACE TO C##TEST1;
ALTER USER C##TEST1 ACCOUNT UNLOCK;

-- 사용자 암호 변경
ALTER USER C##TEST1
IDENTIFIED BY TEST2;

-- 사용자 삭제
-- CASCADE를 사용하며 사용자 이름과 관련된 모든 데이터베이스 스키마가 데이터 사전으로부터 삭제
DROP USER C##TEST1 CASCADE;

-- 트랜잭션
--SAVEPOINT 이름 : 현재까지의 트랜잭션을 특정 이름으로 지정하는 명령
--ROLLBACK TO 이름 : 저장되지 않은 데이터를 모두 취소하고 트랙잭션을 종료
--COMMIT : 저장되지 않은 모든 데이터베이스를 저장하고 현재의 트랙잭션을 종료

SELECT * FROM member1;
TRUNCATE TABLE member1;
COMMIT;

INSERT INTO member1 (ID, PWD, NAME) VALUES('200901','111','KEVIN');
SAVEPOINT SV1;
INSERT INTO member1 (ID, PWD, NAME, AGE) VALUES('200902','112','JAMES',25);
UPDATE member1 SET PWD = '121' WHERE NAME = 'KEVIN';
UPDATE member1 SET PWD = '122',AGE = 20  WHERE ID = '200902';
SAVEPOINT SV2;
INSERT INTO member1 (ID, PWD, NAME, AGE) VALUES('200903','113','SUSAN',35);
--ROLLBACK TO SV1;
UPDATE member1 SET PWD = '131' WHERE NAME = 'KEVIN';
ROLLBACK TO SV2;
DELETE member1 WHERE ID = '200901';
DELETE member1 WHERE ID = '200902';
COMMIT;