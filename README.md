**Storage Method Used**

 - Storage: UserDefaults

 - Contacts are serialized using JSONEncoder/Decoder.

 - Stored under the key "contacts".

 - The last used ID is stored under "lastContactId" to support auto-incrementing IDs.


**Extra Features**

- Input Validation in Contact Form
Validations are implemented in ContactFormViewController to enable or disable the "Save" button based on input completeness. Prevents adding empty or invalid contacts.

- Dual Deletion Options
Users can delete contacts either:

  via swipe-to-delete (native UITableView feature), or

  through a dedicated Delete button within the contact cell or edit form.

- Auto-Incrementing Contact ID
Instead of using random UUIDs, contact IDs are sequentially generated (1, 2, 3, ...) using a stored counter in UserDefaults. This improves readability and traceability.

- Completion Handlers for All Operations
All CRUD methods (Create, Read, Update, Delete) in ContactManager use completion handlers. This ensures asynchronous safety and smoother UI updates without blocking the main thread.

- Contact Editing Support
Tapping on a contact row opens a pre-filled form, allowing users to update existing entries easily. Changes are persisted via the update method.

- Native Swipe-to-Delete UX
Integrated iOS-standard swipe actions using UITableView to delete contacts quickly and intuitively.


**Suggestions for Next Improvements**

- Implement sorting options (e.g., A–Z).

- Replace UserDefaults with Core Data or Realm for scalable persistence.

- Add unit tests and use MVVM for better architecture.
