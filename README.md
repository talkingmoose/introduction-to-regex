# An Introduction to regex
Resources for Penn State University MacAdmins 2020 Campfire session ["Introduction to regex"](https://macadmins.psu.edu/2020/05/26/psumac20-451/) presented June 11.

### Regexes from the presentation

#### Regex to match an email address

`\w{1,64}@\w{1,252}\.\w{2,253}`

#### Regex cheatsheet

```
a b c  ...	=	lower case letters match themselves
A B C ...	=	UPPER case letters match themselves
1 2 3 ...	=	numbers match themselves
.		=	any single character
\ .		=	period
[ a b c ]	=	match one of these characters
[ ^ a b c ]	=	don't match any of these characters
[ a - z ]	=	match any letter a through z
[ A - Z ]	=	match any letter A through Z
[ 0 - 9 ]	=	match any digit 0 through 9
*		=	repeat the character 0 or more times
+		=	repeat the character 1 or more times
{n}		=	repeat the character n times
{m,n}		=	repeat the character
			m through n times
?		=	the character is optional
\w		=	match any letter or number
\d		=	match any digit
\D		=	match any non-digit character
( abc )		=	match the string in parentheses
( a|b|c )	=	or
```

#### BBEdit
[https://barebones.com](https://barebones.com)

Find double words in a text items and replace with single words.

Find:    `(\b\w+\b)\W+\1`

Replace: `\1`

#### Regex for the 62 model identifiers that support macOS Catalina

`(MacBookAir[5-9]|MacBookPro(9|1[0-6])|MacPro[6-7]|iMac(Pro)?1[3-9]?|MacBook(10|9|8)|Macmini[6-8]),\d`

#### grep -E (or egrep)

`grep -E "Pro(1[2-6]|\d)," model-identifiers.txt`

Reads the model-identifiers.txt file and returns all "Pro" models.

```
iMacPro1,1
MacBookPro12,1
MacBookPro13,1
MacBookPro13,2
MacBookPro13,3
MacBookPro14,1
MacBookPro14,2
MacBookPro14,3
MacBookPro15,1
MacBookPro15,2
MacBookPro15,3
MacBookPro15,4
MacBookPro16,1
MacBookPro16,2
MacBookPro16,3
MacPro6,1
MacPro7,1
```

#### awk

`awk -F "," '$2 !~ /MacBookPro1[1-9]/ { print $4 }' assets-list.csv`

Reads the assets-list.csv and returns department names with MacBook Pro model identifiers less than "MacBookPro10".

```
C02X84E1JHF4,"MacBookPro16,3",Customer Service
C02X84E1JHF5,"MacBookPro10,2",Customer Service
C02X84E1JHF6,"MacBookPro10,1",Marketing
C02X84E1JHF7,"MacBookPro11,2",Customer Service
C02X84E1JHF8,"MacBookPro10,2",Marketing
C02X84E1JHF9,"MacBookPro10,1",Marketing
C02X84E1JHF0,"MacBookPro10,1",Customer Service
C02X84E1JHF1,"MacBookPro12,1",Customer Service
C02X84E1JHF2,"MacBookPro11,2",Customer Service
C02X84E1JHF3,"MacBookPro6,1",Sales
```

`uptime | awk -F "(up |, [0-9]+ users)" '{ print $2 }'`

Parses the uptime from five possible formats:

```
17:00 up 5 days, 51 mins, 2 users…
17.10 up 5 days, 1:01, 2 users…
17:00 up 51 secs, 2 users…
17:00 up 2 mins, 2 users…
17:00 up 1:01, 2 users…
```

#### sed

`echo "Martin's MacBook Pro" | sed 's/[^0-9A-Za-z]*//g'`

`MartinsMacBookPro`

Removes all but letters and numbers from a string.

#### Another Rename Computer Script.bash
[https://gist.github.com/talkingmoose/0fbc4213fe92d305f8d72b1a0dabda53](https://gist.github.com/talkingmoose/0fbc4213fe92d305f8d72b1a0dabda53)

Jamf, Catalina and osascript compatible. Prompts to choose a site and enter an asset tag before renaming the Mac and then updating Jamf Pro.

*Smart Computer Group 1:*	`(AVL|BFS|BLR|CHI|GZH|MLB|SBA|SYD)-MAC-\w*[A-Z]\w*`

*Smart Computer Group 2:*	`(AVL|BFS|BLR|CHI|GZH|MLB|SBA|SYD)-MAC-\d{5}`

### Useful websites

#### Semantic Versioning
[https://semver.org/](https://semver.org/)

Given a version number MAJOR.MINOR.PATCH, increment the:

1. MAJOR version when you make incompatible API changes,
2. MINOR version when you add functionality in a backwards compatible manner, and
3. PATCH version when you make backwards compatible bug fixes.

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

#### RegexOne
[https://regexone.com](https://regexone.com)

A great site for learning the basics of regex. Each lesson takes about 5-10 minutes and concentrates on a specific concept like shortcuts, ranges, or capture groups. It makes learning regex fun!

#### Regular-Expressions.info
[https://regular-expressions.info](https://regular-expressions.info)

Once you've learned the basics from RegexOne, Regular-Expressions.info is a great resource for detailed and more extensive uses for regex. Its content is also available as a 400-page downloadable PDF.

#### Mastering Regular Expressions, 3rd Edition, by Jeffrey E. F. Friedl
[O'Reilly](https://www.oreilly.com/library/view/mastering-regular-expressions/0596528124/)

As this book shows, a command of regular expressions is an invaluable skill. Regular expressions allow you to code complex and subtle text processing that you never imagined could be automated. Regular expressions can save you time and aggravation. They can be used to craft elegant solutions to a wide range of problems. Once you've mastered regular expressions, they'll become an invaluable part of your toolkit. You will wonder how you ever got by without them.

#### Regex101.com
[https://regex101.com](https://regex101.com)

Test your regex patterns and experiment. The explanations to the right are useful when you're trying to understand why something does or doesn't work. You'll find dozen's of sites like this for regex validation. This one just happens to have an interface that I find easy to use.

#### Regex Crossword
[https://regexcrossword.com](https://regexcrossword.com)

Practice your regex and have fun at the same time. They have dozens of crosswords across several themes like Cities. So, if you understand the clue, then you're on your way toward solving the puzzle. If you don't understand the clue, you've got regex to help you along.

### Links

#### Match Version Number or Higher.bash
[https://gist.github.com/talkingmoose/2cf20236e665fcd7ec41311d50c89c0e](https://gist.github.com/talkingmoose/2cf20236e665fcd7ec41311d50c89c0e)

Generates a regular expression (regex) that matches the provided version number or higher. Useful for Jamf Pro's "matches regex" operator in searches and smart groups where the results need to be the current version of an app or higher.

### Contact information

@talkingmoose (the Slacks)

@meck (the Twitters)

bil{2}@talkingmo(2}se\\.net (the inboxen) ;-)