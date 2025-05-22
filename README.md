
---

## 📱 ContactApp

A lightweight contact management app built with simplicity and usability in mind.

---

## 🗄️ Storage Method

* **Storage Type:** `UserDefaults`
* **Serialization:** Contacts are encoded/decoded using `JSONEncoder` and `JSONDecoder`.
* **Storage Keys:**

  * `"contacts"` – Stores the list of contacts.
  * `"lastContactId"` – Maintains the last used contact ID to support auto-increment.

---

## ✨ Features

### ✅ Input Validation

* The **Contact Form** uses validation logic in `ContactFormViewController`.
* The "Save" button is only enabled when all fields are properly filled.
* Prevents saving empty or invalid contact entries.

### 🗑️ Dual Deletion Options

Users can delete contacts through:

* **Swipe-to-delete:** Native `UITableView` gesture.
* **Delete Button:** Available within the contact cell or edit form.

### 🔢 Auto-Incrementing Contact IDs

* IDs are generated sequentially (`1, 2, 3, ...`) using a counter stored in `UserDefaults`.
* Improves readability and traceability over using random UUIDs.

### 🔄 Completion Handlers for All Operations

* All CRUD operations (`Create`, `Read`, `Update`, `Delete`) in `ContactManager` support completion handlers.
* Enables non-blocking, asynchronous updates for a smooth user experience.

### ✍️ Contact Editing Support

* Tapping a contact opens a **pre-filled form** for easy updates.
* Changes are saved using the `update` method and persisted.

### 💡 Native Swipe-to-Delete UX

* Fully integrated iOS swipe gestures provide a familiar and intuitive delete action.

---

## 🚀 Suggestions for Future Enhancements

* Add **sorting options** (e.g., alphabetical A–Z).
* Replace `UserDefaults` with **Core Data** or **Realm** for scalable data persistence.
* Introduce **unit tests** and adopt **MVVM architecture** for better code maintainability.

---

