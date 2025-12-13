package com.epam.rd.autotasks;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class NewPostOffice {
    private final Collection<Box> listBox;
    private static final int COST_KILOGRAM = 5;
    private static final int COST_CUBIC_METER = 100;
    private static final double COEFFICIENT = 0.5;

    public NewPostOffice() {
        listBox = new ArrayList<>();
    }

    public Collection<Box> getListBox() {
        return (Collection<Box>) ((ArrayList<Box>) listBox).clone();
    }

    static BigDecimal calculateCostOfBox(double weight, double volume, int value) {
        BigDecimal costWeight = BigDecimal.valueOf(weight)
                .multiply(BigDecimal.valueOf(COST_KILOGRAM), MathContext.DECIMAL64);
        BigDecimal costVolume = BigDecimal.valueOf(volume)
                .multiply(BigDecimal.valueOf(COST_CUBIC_METER), MathContext.DECIMAL64);
        return costVolume.add(costWeight)
                .add(BigDecimal.valueOf(COEFFICIENT * value), MathContext.DECIMAL64);
    }

    public boolean addBox(String addresser, String recipient, double weight, double volume, int value) {
        if (addresser == null || addresser.trim().isEmpty() ||
                recipient == null || recipient.trim().isEmpty() ||
                weight < 0.5 || weight > 20.0 ||
                volume <= 0.0 || volume > 0.25 ||
                value <= 0) {
            throw new IllegalArgumentException("Invalid box parameters");
        }

        Box box = new Box(addresser, recipient, weight, volume);
        box.setCost(calculateCostOfBox(weight, volume, value));
        return listBox.add(box);
    }

    // Доставка всех посылок указанного получателя
    public Collection<Box> deliveryBoxToRecipient(String recipient) {
        Collection<Box> delivered = new ArrayList<>();
        Iterator<Box> it = listBox.iterator();
        while (it.hasNext()) {
            Box box = it.next();
            if (box.getRecipient().equals(recipient)) {
                delivered.add(box);
                it.remove(); // удаляем из офиса
            }
        }
        return delivered;
    }

    // Уменьшение стоимости всех посылок на заданный процент
    public void declineCostOfBox(double percent) {
        if (percent < 0) {
            throw new IllegalArgumentException("Percent must be positive");
        }
        Iterator<Box> it = listBox.iterator();
        while (it.hasNext()) {
            Box box = it.next();
            BigDecimal factor = BigDecimal.valueOf(1.0 - percent / 100.0);
            box.setCost(box.getCost().multiply(factor, MathContext.DECIMAL64));
        }
    }
}

