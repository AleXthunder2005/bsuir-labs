package com.epam.rd.autotasks.sprintplanning.tickets;

public class Bug extends Ticket {

    private final UserStory relatedStory;

    private Bug(int id, String name, int estimate, UserStory userStory) {
        super(id, name, estimate);
        this.relatedStory = userStory;
    }

    public static Bug createBug(int id, String name, int estimate, UserStory userStory) {
        if (userStory == null || !userStory.isCompleted()) {
            return null;
        }
        return new Bug(id, name, estimate, userStory);
    }

    @Override
    public String toString() {
        return "[Bug " + getId() + "] " + relatedStory.getName() + ": " + getName();
    }
}
