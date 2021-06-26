# prototype


=================================================================================================
The program has 3 methods to accomplish the requirement and uses sqlite DB for data storage
=================================================================================================

The full prototype you have been contracted to provide will support adding/removing products
owned by customers and listing an email schedule.
Adding a product requires five pieces of information:

● CustomerId (e.g., “Cust123”)
● ProductName (e.g., “domain”)
● Domain (e.g., “xyzzy.com”)
● StartDate (e.g., “2020-01-01”)
● DurationMonths (e.g., 12)

Removing a product requires three pieces of information.
● CustomerId (e.g., “Cust123”)
● ProductName (e.g., “domain”)
● Domain (e.g., “xyzzy.com”)

Listing the email schedule returns a list of scheduled email (sorted by date).

Company Products
Only three products are offered presently (with additional products planned for the future):
Domain, Hosting, and Protected Domain (“pdomain”).
● Domain sends email 2 days before expiration.
● Hosting sends email 1 day after activation and 3 days before expiration.
● Protected Domain sends email 9 days before expiration and 2 days before expiration.

=================================================================================================