package com.epam.rd.autotasks.sprintplanning.tickets;

public class UserStory extends Ticket {

    private final UserStory[] dependencies;

    public UserStory(int id, String name, int estimate, UserStory... dependsOn) {
        super(id, name, estimate);
        if (dependsOn == null) {
            this.dependencies = new UserStory[0];
        } else {
            this.dependencies = new UserStory[dependsOn.length];
            for (int i = 0; i < dependsOn.length; i++) {
                this.dependencies[i] = dependsOn[i];
            }
        }
    }

    @Override
    public void complete() {
        // можно завершить только если все зависимости завершены
        for (int i = 0; i < dependencies.length; i++) {
            if (!dependencies[i].isCompleted()) {
                return;
            }
        }
        super.complete();
    }

    public UserStory[] getDependencies() {
        // возвращаем копию массива, чтобы не было модификаций извне
        UserStory[] copy = new UserStory[dependencies.length];
        for (int i = 0; i < dependencies.length; i++) {
            copy[i] = dependencies[i];
        }
        return copy;
    }

    @Override
    public String toString() {
        return "[US " + getId() + "] " + getName();
    }
}
