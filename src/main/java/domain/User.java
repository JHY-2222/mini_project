package domain;

import lombok.Data;

@Data
public class User {
    private String userId;
    private String pwd;
    private String nickname;
    private String avatar;
    private String email;
    private String img;
    private int stone_style;
    private int score;
    private String is_guest;   
}