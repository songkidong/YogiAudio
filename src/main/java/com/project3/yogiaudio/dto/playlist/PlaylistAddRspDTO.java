package com.project3.yogiaudio.dto.playlist;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.music.MusicDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
  * @FileName : PlayListAddDTO.java
  * @Project : YogiAudio
  * @Date : 2024. 3. 15. 
  * @작성자 : 최장호
  * @변경이력 :
  * @프로그램 설명 : 플레이리스트 추가 DTO
  */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlaylistAddRspDTO {
	private String playlistName;
	private long userId;
	private long orderIndex;
	private long musicNo;
	private String musictitle;
	private String musicsinger;
	private String musiccontent;
	private String musiccompany;
	private String lyrics;
	private String startdate;
	private Timestamp regdate;
	private String filepath;
	private String filemusic;
	private String musicsample;
	private String musicmajor;
	private String musicminor;
	private int musicprice;
	private String status;
	private int likeit;
	private String mvfile;
	private String videocontent;
	private List<MultipartFile> files; // 파일 url
	
	// MusicDTO를 PlaylistAddRspDTO로 변환하여 설정하는 메소드
    public void setFromMusicDTO(MusicDTO musicDTO) {
        if (musicDTO != null) {
            this.musicNo = musicDTO.getMusicno();
            this.musictitle = musicDTO.getMusictitle();
            this.musicsinger = musicDTO.getMusicsinger();
            this.musiccontent = musicDTO.getMusiccontent();
            this.musiccompany = musicDTO.getMusiccompany();
            this.lyrics = musicDTO.getLyrics();
            this.startdate = musicDTO.getStartdate();
            this.regdate = musicDTO.getRegdate();
            this.filepath = musicDTO.getFilepath();
            this.filemusic = musicDTO.getFilemusic();
            this.musicsample = musicDTO.getMusicsample();
            this.musicmajor = musicDTO.getMusicmajor();
            this.musicminor = musicDTO.getMusicminor();
            this.musicprice = musicDTO.getMusicprice();
            this.status = musicDTO.getStatus();
            this.likeit = musicDTO.getLikeit();
            this.mvfile = musicDTO.getMvfile();
            this.videocontent = musicDTO.getVideocontent();
            this.files = musicDTO.getFiles();
        }
    }

}
