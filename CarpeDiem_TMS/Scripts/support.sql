-- 고객지원 게시판 쿼리테스트
--회원가입을 하는 기능
INSERT INTO "MEMBER"(EMAIL, NICKNAME, PASSWORD, AUTH, WITHDRAWAL, JOINDATE)
VALUES('user2@naver.com','USER','USER','U','N',SYSDATE);

-- 문의 게시판
CREATE TABLE QUESTIONBOARD (
	SEQ NUMBER NOT NULL,
	WRITER VARCHAR2(80),
	TITLE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	TEXT_PW CHAR(4),
	TEXT_REGDATE DATE NOT NULL,
	PUBLIC_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
	DELFLAG CHAR(1) DEFAULT 'N' NOT NULL,
	REFER NUMBER NOT NULL,
	DEPTH NUMBER NOT NULL,
	CONSTRAINT "QUESTIONBOARD_PK" PRIMARY KEY("SEQ")
);

-- 테이블 삭제
DROP TABLE INQUIRYBOARD;

-- 제약조건 삭제
ALTER TABLE INQUIRYBOARD DROP CONSTRAINT "INQUIRYBOARD_PK";

-- 신고처리 게시판
CREATE TABLE REPORTBOARD (
	SEQ NUMBER NOT NULL,
	EMAIL VARCHAR2(50) NOT NULL,
	REPORT_TYPE VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	TEXT_REGDATE DATE NOT NULL,
	PROCESSING_STATUS CHAR(1) DEFAULT 'N' NOT NULL,
	BOARD_TYPE VARCHAR2(50) NOT NULL,
	CONSTRAINT "REPORTBOARD_PK" PRIMARY KEY("SEQ")
);

CREATE SEQUENCE QUESTIONBOARD_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE REPORTBOARD_SEQ START WITH 1 INCREMENT BY 1;

-- 문의 게시판
-- CP55111 전체조회(비회원/회원)
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG 
	FROM QUESTIONBOARD
		WHERE DELFLAG = 'N'
		ORDER BY REFER DESC, DEPTH;

-- CP55112 전체조회(관리자)
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG, PUBLIC_STATUS 
	FROM QUESTIONBOARD
		ORDER BY REFER DESC, DEPTH;

-- CP55113 상세조회
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, DELFLAG 
	FROM QUESTIONBOARD
		WHERE SEQ = '3';

-- CP55121 글 입력(비회원/회원)
INSERT INTO QUESTIONBOARD
(SEQ, WRITER, TITLE, 
CONTENT, TEXT_PW, REFER, 
"DEPTH", DELFLAG, TEXT_REGDATE)
VALUES(QUESTIONBOARD_SEQ.NEXTVAL, '회원6', '문의글6',
'문의글', '1234', (SELECT NVL(MAX(REFER),0)+1 FROM QUESTIONBOARD),
0, 'N', SYSDATE);

-- CP55122 글 입력(관리자)
INSERT INTO QUESTIONBOARD
(SEQ, WRITER, TITLE, 
CONTENT, PUBLIC_STATUS, REFER, 
"DEPTH", DELFLAG, TEXT_REGDATE)
VALUES(QUESTIONBOARD_SEQ.NEXTVAL, '관리자', '공지글',
'공지글', 'Y', (SELECT NVL(MAX(REFER),0)+1 FROM QUESTIONBOARD),
0, 'N', SYSDATE);

-- CP55123 답글 입력(관리자)
INSERT INTO QUESTIONBOARD
(SEQ, WRITER, TITLE, 
CONTENT, TEXT_PW, 
REFER, 
"DEPTH", DELFLAG, TEXT_REGDATE)
VALUES(QUESTIONBOARD_SEQ.NEXTVAL, '관리자', '문의글2 답글',
'관리자 답글', (SELECT TEXT_PW FROM QUESTIONBOARD WHERE SEQ='2'), 
(SELECT REFER FROM QUESTIONBOARD WHERE SEQ='2'),
(SELECT "DEPTH" FROM QUESTIONBOARD WHERE SEQ='2')+1, 'N', SYSDATE);

-- CP55131 글 수정
UPDATE QUESTIONBOARD SET TITLE = '비회원 글 수정', CONTENT = '글 수정'
	WHERE SEQ='3';

-- CP55132 글 수정(관리자)
UPDATE QUESTIONBOARD SET TITLE = '관리자 글 수정', CONTENT = '글 수정', PUBLIC_STATUS = 'Y'
	WHERE SEQ='5';

-- CP55141 글 삭제(root글 삭제 시 댓글도 삭제 됨, delflag 변경)
UPDATE QUESTIONBOARD SET DELFLAG='Y'
 WHERE REFER=(SELECT REFER FROM QUESTIONBOARD WHERE SEQ='1');

-- CP55143 다중삭제(관리자)
UPDATE QUESTIONBOARD SET DELFLAG='Y'
	WHERE SEQ IN ('6', '7');


-- 신고처리 게시판
-- 회원 입력
INSERT INTO MEMBER2(EMAIL, NICKNAME, PASSWORD, AUTH, WITHDRAWAL, JOINDATE)
	VALUES('teddy2@naver.com', '테디2', 'hello', 'U', 'N', SYSDATE);
INSERT INTO MEMBER2(EMAIL, NICKNAME, PASSWORD, AUTH, WITHDRAWAL, JOINDATE)
	VALUES('admin@naver.com', 'ADMIN', 'ADMIN', 'A', 'N', SYSDATE);

-- CP55241 신고 양식 작성
-- 신고글 입력
INSERT INTO REPORTBOARD(SEQ, EMAIL, REPORT_TYPE, CONTENT, TEXT_REGDATE)
VALUES(REPORTBOARD_SEQ.NEXTVAL, 'katie@naver.com', '욕설/비방', '심한 욕설을 하여 신고합니다.', SYSDATE);

-- CP55151 전체조회
SELECT SEQ, EMAIL, REPORT_TYPE, TEXT_REGDATE, PROCESSING_STATUS, BOARD_TYPE
	FROM REPORTBOARD r;

-- CP55152 상세조회
SELECT SEQ, EMAIL, REPORT_TYPE, CONTENT, TEXT_REGDATE, PROCESSING_STATUS, BOARD_TYPE
	FROM REPORTBOARD r 
		WHERE SEQ = '4';

-- CP55154 신고처리(탈퇴여부 변경)
-- 회원 테이블에서 변경해줘야 함
UPDATE MEMBER2 SET WITHDRAWAL='Y'
	WHERE EMAIL='katie@naver.com';

-- CP55155 신고처리 완료(처리여부 변경)
UPDATE REPORTBOARD SET PROCESSING_STATUS='Y'
	WHERE SEQ='4';


-- 페이징(전체조회)
-- 문의 게시판
-- 비회원/회원
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG
	FROM(SELECT ROWNUM RN, S1.* 
			FROM(SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG 
					FROM QUESTIONBOARD
						WHERE DELFLAG = 'N'
						ORDER BY REFER DESC) S1)
		WHERE RN BETWEEN 1 AND 10;

-- 위아래 쿼리 동일
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY REFER DESC) RN,
			SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG
			FROM QUESTIONBOARD
				WHERE DELFLAG='N')
		WHERE RN BETWEEN 1 AND 10;

-- 관리자
SELECT SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY REFER DESC) RN,
			SEQ, WRITER, TITLE, CONTENT, TEXT_REGDATE, REFER, "DEPTH", DELFLAG
			FROM QUESTIONBOARD)
		WHERE RN BETWEEN 1 AND 10;

	
-- 신고처리 게시판
SELECT SEQ, EMAIL, REPORT_TYPE, TEXT_REGDATE, PROCESSING_STATUS, BOARD_TYPE
	FROM (SELECT ROW_NUMBER() OVER(ORDER BY SEQ DESC) RN,
			SEQ, EMAIL, REPORT_TYPE, TEXT_REGDATE, PROCESSING_STATUS, BOARD_TYPE
			FROM REPORTBOARD r)
		WHERE RN BETWEEN 1 AND 10;
		
DELETE FROM REVIEWBOARD r WHERE PLACE_SEQ =2;

-- 신고하기 test
INSERT INTO REPORTBOARD(SEQ, EMAIL, REPORT_TYPE, CONTENT, TEXT_REGDATE, PROCESSING_STATUS, BOARD_TYPE)
VALUES(REPORTBOARD_SEQ.NEXTVAL, 'user2@naver.com', '욕설/비방', '심한 욕설을 하여 신고합니다.', SYSDATE, 'N', 'QUESTIONBOARD');
