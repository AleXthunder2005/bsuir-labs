package com.epam.rd.autotasks.sprintplanning;

import com.epam.rd.autotasks.sprintplanning.tickets.Bug;
import com.epam.rd.autotasks.sprintplanning.tickets.Ticket;
import com.epam.rd.autotasks.sprintplanning.tickets.UserStory;

public class Sprint {

    private final int capacity;       // общая вместимость спринта (часы)
    private final int ticketsLimit;   // максимальное количество тикетов
    private final Ticket[] tickets;   // массив для хранения тикетов
    private int count;                // сколько тикетов уже добавлено

    public Sprint(int capacity, int ticketsLimit) {
        this.capacity = capacity;
        this.ticketsLimit = ticketsLimit;
        this.tickets = new Ticket[ticketsLimit];
        this.count = 0;
    }

    public boolean addUserStory(UserStory userStory) {
        if (userStory == null || userStory.isCompleted()) return false;
        if (count >= ticketsLimit) return false;
        if (getTotalEstimate() + userStory.getEstimate() > capacity) return false;

        // проверка зависимостей
        UserStory[] deps = userStory.getDependencies();
        for (int i = 0; i < deps.length; i++) {
            if (!deps[i].isCompleted() && !containsTicket(deps[i])) {
                return false;
            }
        }

        tickets[count++] = userStory;
        return true;
    }

    public boolean addBug(Bug bug) {
        if (bug == null || bug.isCompleted()) return false;
        if (count >= ticketsLimit) return false;
        if (getTotalEstimate() + bug.getEstimate() > capacity) return false;

        tickets[count++] = bug;
        return true;
    }

    public Ticket[] getTickets() {
        Ticket[] copy = new Ticket[count];
        for (int i = 0; i < count; i++) {
            copy[i] = tickets[i];
        }
        return copy;
    }

    public int getTotalEstimate() {
        int sum = 0;
        for (int i = 0; i < count; i++) {
            sum += tickets[i].getEstimate();
        }
        return sum;
    }

    // Вспомогательный метод для проверки, есть ли тикет в спринте
    private boolean containsTicket(Ticket t) {
        for (int i = 0; i < count; i++) {
            if (tickets[i] == t) return true;
        }
        return false;
    }
}
