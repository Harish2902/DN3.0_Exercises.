package libraryManagementSystem;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

// Step 2: Create a Book class
class Book {
    int bookId;
    String title;
    String author;

    public Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }

    @Override
    public String toString() {
        return "Book [bookId=" + bookId + ", title=" + title + ", author=" + author + "]";
    }
}

// Step 3: Implement linear search
class Library {
    List<Book> books = new ArrayList<>();

    public void addBook(Book book) {
        books.add(book);
    }

    public Book linearSearchByTitle(String title) {
        for (Book book : books) {
            if (book.title.equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null; // Not found
    }

    // Binary search requires the list to be sorted by title
    public void sortBooksByTitle() {
        Collections.sort(books, Comparator.comparing(book -> book.title));
    }

    public Book binarySearchByTitle(String title) {
        int left = 0;
        int right = books.size() - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int cmp = books.get(mid).title.compareToIgnoreCase(title);

            if (cmp == 0) {
                return books.get(mid); // Found
            } else if (cmp < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null; // Not found
    }
}

// Main class to test the Library Management System
public class LibraryManagementSystem {
    public static void main(String[] args) {
        Library library = new Library();
        
        // Adding some books
        library.addBook(new Book(1, "The Catcher in the Rye", "J.D. Salinger"));
        library.addBook(new Book(2, "To Kill a Mockingbird", "Harper Lee"));
        library.addBook(new Book(3, "1984", "George Orwell"));
        library.addBook(new Book(4, "The Great Gatsby", "F. Scott Fitzgerald"));

        // Linear search example
        String titleToSearch = "1984";
        Book foundBook = library.linearSearchByTitle(titleToSearch);
        System.out.println("Linear Search - Found: " + foundBook);

        // Sorting the books by title for binary search
        library.sortBooksByTitle();

        // Binary search example
        foundBook = library.binarySearchByTitle(titleToSearch);
        System.out.println("Binary Search - Found: " + foundBook);
    }
}