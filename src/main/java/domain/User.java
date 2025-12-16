package domain;

public class User {
	private String userId;
    private String name;
    private int score;

    public User(String userId, String name, int score) {
        this.userId = userId;
        this.name = name;
        this.score = score;
    }

    public String getUserId() { return userId; }
    public String getName() { return name; }
    public int getScore() { return score; }
}
