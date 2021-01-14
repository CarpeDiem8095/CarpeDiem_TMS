SELECT * FROM place;
SELECT PLACE_SEQ ,UUID_NAME ,ORIGIN_NAME ,IMG_URL ,REVIEW_TITLE ,CONTENT 
	FROM REVIEWBOARD r JOIN PLACE p 
						ON PLACE SEQ
	WHERE PLACE_SEQ = 2;


place_seq=2, uuid_name=12ff8ab9957d4eb5bbe8f6e61a8ea0cc, origin_name=bird.png, img_url=/Users/EUNSOL/CarpeDiem_TMS_WorkSpace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps, review_title=null, content=null



INSERT INTO REVIEWBOARD(PLACE_SEQ, UUID_NAME, ORIGIN_NAME, IMG_URL, CONTENT)
	VALUES('2', '12ff8ab9957d4eb5bbe8f6e61a8ea0cc', 'bird.png', '/Users/EUNSOL/CarpeDiem_TMS_WorkSpace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps', null);