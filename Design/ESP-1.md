# Emergency Service and Product

## Customer Details View

### 0NF

**Customer:** <span class="md"><b class="pk">Customer Number</b>, FirstName, LastName, Address, City, Province, PostalCode, HomePhone</span>

### 1NF - 3NF

*No changes to the entity in 1NF through 3NF. *

### ERD

> TODO: **Image here**

## Customer Orders View

### 0NF

**Order:** <span class="md"><b class="pk">OrderNumber</b>, CustomerNumber, FirstName, LastName, Address, City, Province, PostalCode, Phone, Date<b class="rg">ItemNumber, Description, Quantity, CurrentPrice, SellingPrice, Amount</b>, SubTotal, GST, Total</span>

### 1NF

**Order** <span class="md"><b class="pk">OrderNumber</b>, CustomerNumber, FirstName, LastName, Address, City, Province, PostalCode, Phone, Date, SubTotal, GST, Total</span>

**OrderDetail** <span class="md"><b class="pk"><u class="fk">OrderNumber</u>, ItemNumber</b>, Description, Quantity, CurrentPrice, SellingPrice,Amount</span>

### 2NF

**OrderDetail** <span class="md"><b class="pk"><u class="fk">OrderNumber</u>,<u class="fk">ItemNumber</u></b>, Quantity, SellingPrice, Amount</span>

**Item:** <span class="md"><b class="pk">ItemNumber</b>, Description, CurrentPrice</span>

### 3NF

**Order** <span class="md"><b class="pk">OrderNumber</b>, <u class="fk">CustomerNumber</u>, Date, SubTotal, GST, Total</span>

**Customer** <span class="md"><b class="pk">CustomerNumber</b>, FirstName, LastName, Address, City, Province, PostalCode, Phone</span>

### ERD

> TODO: *ERD Image here.*

----

## Legend

This legend is a guide to reading and interpreting the table listings under 0NF through 3NF.

- **TableName:** - Table names will be bolded and end with a colon. (e.g.: `**TableName:**`)
- (Column, Names) - Column names for a table will be enclosed in (rounded parenthesis).
- <b class="pk">PrimaryKeyFields</b> - Primary key fields will be bold and inside a box. (e.g: `<b class="pk">PrimaryKeyFields</b>`)
- <u class="fk">ForeignKeyFields</u> - Foreign key fields will be a wavy underline in italic and green. (e.g.: `<u class="fk">ForeignKeyFields</u>`)
- <b class="rg">{</b>Repeating Groups<b class="rg">}</b> - Groups of repeating fields will be identified in 0NF stage, and will be enclosed in orange curly braces. (e.g.: `<b class="rg">{</b>Repeating, Group, Fields<b class="rg">}</b>`)



----

<style type="text/css">
.pk {
    font-weight: bold;
    display: inline-block;
    border: solid thin blue;
    padding: 0 1px;
}
.fk {
    color: green;
    font-style: italic;
    text-decoration: wavy underline green;    
}
.rg {
    color: darkorange;
    font-size: 1.2em;
    font-weight: bold;
}
.note {
    font-weight: bold;
    color: brown;
    font-size: 1.1em;
}
</style>