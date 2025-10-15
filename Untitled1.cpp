#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Khai báo m?ng và bi?n toàn c?c
#define MAX 100
int arr[MAX];
int n = 0; // s? ph?n t? hi?n có

// 1. Nh?p m?ng
void inputArray() {
    printf("Nhap so phan tu (1 - 100): ");
    scanf("%d", &n);
    if (n < 1 || n > MAX) {
        printf("So phan tu khong hop le!\n");
        n = 0;
        return;
    }
    for (int i = 0; i < n; i++) {
        printf("arr[%d] = ", i);
        scanf("%d", &arr[i]);
    }
}

// 2. Xu?t m?ng
void outputArray() {
    if (n == 0) {
        printf("Mang rong!\n");
        return;
    }
    printf("Cac phan tu trong mang: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

// 3. In m?ng gi?m d?n
void printDescending() {
    if (n == 0) {
        printf("Mang rong!\n");
        return;
    }
    // S?p x?p m?ng t?m
    int temp[MAX];
    for (int i = 0; i < n; i++) temp[i] = arr[i];

    for (int i = 0; i < n - 1; i++) {
        for (int j = i + 1; j < n; j++) {
            if (temp[i] < temp[j]) {
                int t = temp[i];
                temp[i] = temp[j];
                temp[j] = t;
            }
        }
    }

    printf("Mang sap xep giam dan: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", temp[i]);
    }
    printf("\n");
}

// 4. Ki?m tra t?t c? ph?n t? là s? l?
void checkAllOdd() {
    if (n == 0) {
        printf("Mang rong!\n");
        return;
    }
    bool allOdd = true;
    for (int i = 0; i < n; i++) {
        if (arr[i] % 2 == 0) {
            allOdd = false;
            break;
        }
    }
    if (allOdd)
        printf("Tat ca phan tu trong mang deu la so le.\n");
    else
        printf("Mang co phan tu khong phai so le.\n");
}

// 5. Tìm ki?m 1 giá tr?
void searchValue() {
    if (n == 0) {
        printf("Mang rong!\n");
        return;
    }
    int x, count = 0;
    printf("Nhap gia tri can tim: ");
    scanf("%d", &x);
    for (int i = 0; i < n; i++) {
        if (arr[i] == x) count++;
    }
    printf("Gia tri %d xuat hien %d lan trong mang.\n", x, count);
}

// Hàm ki?m tra s? nguyên t?
bool isPrime(int x) {
    if (x < 2) return false;
    for (int i = 2; i * i <= x; i++) {
        if (x % i == 0) return false;
    }
    return true;
}

// 6. Hi?n th? s? nguyên t? trong m?ng
void displayPrimes() {
    if (n == 0) {
        printf("Mang rong!\n");
        return;
    }
    printf("Cac so nguyen to trong mang: ");
    bool found = false;
    for (int i = 0; i < n; i++) {
        if (isPrime(arr[i])) {
            printf("%d ", arr[i]);
            found = true;
        }
    }
    if (!found) printf("(khong co)");
    printf("\n");
}

// 7. Thoát chuong trình
bool quit() {
    int confirm;
    printf("Ban co chac muon thoat? (1 = Yes, 0 = No): ");
    scanf("%d", &confirm);
    return (confirm == 1);
}

// MENU chính
int main() {
    int choice;
    do {
        printf("\n===== MENU =====\n");
        printf("1. Nhap mang\n");
        printf("2. Xuat mang\n");
        printf("3. In mang giam dan\n");
        printf("4. Kiem tra tat ca phan tu la so le\n");
        printf("5. Tim kiem 1 gia tri\n");
        printf("6. Hien thi cac so nguyen to trong mang\n");
        printf("7. Thoat\n");
        printf("Chon chuc nang: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1: inputArray(); break;
            case 2: outputArray(); break;
            case 3: printDescending(); break;
            case 4: checkAllOdd(); break;
            case 5: searchValue(); break;
            case 6: displayPrimes(); break;
            case 7:
                if (quit()) {
                    printf("Chuong trinh ket thuc.\n");
                    exit(0);
                }
                break;
            default:
                printf("Lua chon khong hop le!\n");
        }
    } while (1);

    return 0;
}

