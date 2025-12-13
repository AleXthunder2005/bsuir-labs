package com.epam.rd.contactbook;

public class Contact {

    private String name;
    private ContactInfo phoneNumber;
    private final Email[] emails = new Email[3];
    private int emailCount = 0;
    private final Social[] socialMedias = new Social[5];
    private int socialCount = 0;

    public Contact(String contactName) {
        if (contactName == null || contactName.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }
        this.name = contactName;
    }

    public void rename(String newName) {
        if (newName == null || newName.isEmpty()) return;
        this.name = newName;
    }

    private class NameContactInfo implements ContactInfo {
        @Override
        public String getTitle() {
            return "Name";
        }

        @Override
        public String getValue() {
            return name;
        }
    }

    public static class Email implements ContactInfo {
        protected String localPart;
        protected String domain;

        public Email(String localPart, String domain) {
            this.localPart = localPart;
            this.domain = domain;
        }

        @Override
        public String getTitle() {
            return "Email";
        }

        @Override
        public String getValue() {
            return localPart + "@" + domain;
        }
    }

    public static class Social implements ContactInfo {
        private final String title;
        private final String id;

        public Social(String title, String id) {
            this.title = title;
            this.id = id;
        }

        @Override
        public String getTitle() {
            return title;
        }

        @Override
        public String getValue() {
            return id;
        }
    }

    public Email addEmail(String localPart, String domain) {
        if (emailCount >= 3) return null;
        Email email = new Email(localPart, domain);
        emails[emailCount++] = email;
        return email;
    }

    // анонимный класс
    public Email addEpamEmail(String firstname, String lastname) {
        if (emailCount >= 3) return null;
        Email epamEmail = new Email(firstname + "_" + lastname, "epam.com") {
            @Override
            public String getTitle() {
                return "Epam Email";
            }
        };
        emails[emailCount++] = epamEmail;
        return epamEmail;
    }

    // анонимный класс
    public ContactInfo addPhoneNumber(int code, String number) {
        if (phoneNumber != null) return null;
        phoneNumber = new ContactInfo() {
            @Override
            public String getTitle() {
                return "Tel";
            }

            @Override
            public String getValue() {
                return "+" + code + " " + number;
            }
        };
        return phoneNumber;
    }

    public Social addTwitter(String twitterId) {
        return addSocialMedia("Twitter", twitterId);
    }

    public Social addInstagram(String instagramId) {
        return addSocialMedia("Instagram", instagramId);
    }

    public Social addSocialMedia(String title, String id) {
        if (socialCount >= 5) return null;
        Social social = new Social(title, id);
        socialMedias[socialCount++] = social;
        return social;
    }

    public ContactInfo[] getInfo() {
        int size = 1 + (phoneNumber != null ? 1 : 0) + emailCount + socialCount;
        ContactInfo[] info = new ContactInfo[size];
        int index = 0;
        info[index++] = new NameContactInfo();
        if (phoneNumber != null) info[index++] = phoneNumber;
        for (int i = 0; i < emailCount; i++) {
            info[index++] = emails[i];
        }
        for (int i = 0; i < socialCount; i++) {
            info[index++] = socialMedias[i];
        }
        return info;
    }
}
