package test;

import java.util.List;

import com.cp.tms.dto.NoteDto;
import com.cp.tms.model.schedule.INoteService;
import com.cp.tms.model.schedule.INoteServiceImpl;

public class TestMain {

	public static void main(String[] args) {
		INoteService service = new INoteServiceImpl();

		NoteDto dto = new NoteDto();
		
		List<NoteDto> note = service.selDetailNote("62");
		System.out.println(note);
		
		
//		KaoMapDao dao = new KaoMapDaoImpl();
//		String email = "A001";
//		List<KaoMapDto> dto = dao.selAllNote(email);
//		KaoMapDto note = service.selDetailNote("1");
//		for(KaoMapDto dtos : dto) {
//			System.out.println(dtos);
//		}
		
//		KaoMapDto dto = new KaoMapDto();
//		dto.setEmail("A001");
//		dto.setNote_title("안녕하세요");
//		System.out.println(service.writeNote(dto));
		
	}
}
