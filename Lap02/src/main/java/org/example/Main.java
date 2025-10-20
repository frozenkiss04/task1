package org.example;

import java.util.Scanner;

public class Main {
    static int Max = 100;
    static Student[] st1 = new Student[Max];
    static int count =0;

    static boolean isDuplicateId(String id) {
        for (int i = 0; i < count; i++) {
            if (st1[i].id.equals(id)) {
                return true;
            }
        }
        return false;
    }

    static void createStudent(Scanner sc){
        if(count >Max){
            System.out.println("List full baby!");
            return;
        }
        Student s = new Student();
        System.out.println("Enter id:");
        s.id = sc.nextLine();
        if(isDuplicateId(s.id)){
            System.out.println("ID exists!");
            return;
        }
        System.out.print("Enter name: ");
        s.name = sc.nextLine();
        if (s.name.trim().equals("")) {
            System.out.println(" Name can't be empty!");
            return;
        }

        System.out.print("Enter age: ");
        s.age = sc.nextInt();
        sc.nextLine();
        if (s.age < 18) {
            System.out.println(" Age must be >= 18!");
            return;
        }

        System.out.print("Enter address: ");
        s.address = sc.nextLine();

        System.out.print("Enter gender (male/female): ");
        s.gender = sc.nextLine();
        if (!s.gender.equals("male") && !s.gender.equals("female")&& !s.gender.equals("LGPT")) {
            System.out.println("Gender must be male or female! or LGPT");
            return;
        }

        System.out.print("Enter email: ");
        s.email = sc.nextLine();

        st1[count] = s;
        count++;
        System.out.println(" Student created successfully!");
    }

     static void displayAll() {
        if (count == 0) {
            System.out.println("No students to display.");
            return;
        }
        for (int i = 0; i < count; i++) {
            st1[i].display();
        }
     }

     static int getStudentIndexById(String id) {
        for (int i = 0; i < count; i++) {
            if (st1[i].id.equals(id)) {
                return i;
            }
        }
        return -1;
    }

    static void findStudentById(Scanner sc) {
        System.out.print("Enter id to find: ");
        String id = sc.nextLine();
        int index = getStudentIndexById(id);
        if (index != -1) {
            st1[index].display();
        } else {
            System.out.println(" Student not found!");
        }
    }

    static void updateStudentById(Scanner sc) {
        System.out.print("Enter id to update: ");
        String id = sc.nextLine();
        int index = getStudentIndexById(id);
        if (index == -1) {
            System.out.println(" Student not found!");
            return;
        }

        Student s = st1[index];

        System.out.print("New name : ");
        String name = sc.nextLine();
        if (!name.trim().equals("")) s.name = name;

        System.out.print("New age : ");
        int age = sc.nextInt();
        sc.nextLine();
        if (age >= 18) s.age = age;

        System.out.print("New address : ");
        String address = sc.nextLine();
        if (!address.trim().equals("")) s.address = address;

        System.out.print("New gender : ");
        String gender = sc.nextLine();
        if (gender.equals("male") || gender.equals("female")) s.gender = gender;

        System.out.print("New email : ");
        String email = sc.nextLine();
        if (!email.trim().equals("")) s.email = email;

        System.out.println(" Student updated!");
    }


    public  static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;
        do{
            System.out.println("===== STUDENT MANAGEMENT =====");
            System.out.println("1. Create a student");
            System.out.println("2. Display all");
            System.out.println("3. Find a student by id");
            System.out.println("4. Update a student by id");
            System.out.println("5. Quit");
            System.out.print("Choose: ");
            choice = sc.nextInt();
            sc.nextLine();
            if (choice == 1) {
                createStudent(sc);
            } else if (choice == 2) {
                displayAll();
            } else if (choice == 3) {
                findStudentById(sc);
            } else if (choice == 4) {
                updateStudentById(sc);
            } else if (choice == 5) {
                System.out.println("Exiting program...");
            } else {
                System.out.println("Invalid choice!");
            }

        } while (choice != 5);
    }

}
