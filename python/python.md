## PYTHON

Python code must always be run by an intrepreter.

When source code is exectued, python compiles it into a byte code which is a low-level platform-independent representation of the source code. IT IS NOT BINARY MACHINE CODE
- compilation is a *translation* step

Each statement of the source code is translated into byte code instructions by decomposing them into individual steps. This speeds the execution of the code. Byte code files have a .pyc extension.

> When a Python executes a program, Python reads the .py into memory, and parses it in order to get a bytecode, then goes on to execute. For each module that is imported by the program, Python first checks to see whether there is a precompiled bytecode version, in a .pyo or .pyc, that has a timestamp which corresponds to its .py file. Python uses the bytecode version if any. Otherwise, it parses the module's .py file, saves it into a .pyc file, and uses the bytecode it just created.

No compile-time phase. Python is runtime, everything happens as the program is running. 

Frozen binaries are true executables. They contain the byte code of our program along with the PVM interpreter and any Python support files our program needs and bundles them into a single package like an .exe on Windows. 

Three primary systems are capable of generating frozen binaries:

   - py2exe for Windows.
   - PyInstaller is similar to py2exe but also works on Linux and Unix.
   - freeze.

---

Can test and run code on the fly. Doesn't save the code into a file.

Namespaces

Python programs are composed of multiple module files, linked togehter by an import statement. Each module file is a self-contained package of variables, ie a namespace. One module cannot see the names defined in another module unless it explicitly imports that other file. 
- modules serve to minimize name collisions in our code. 


exec ---> similar effect to import but it doesn't import the module. 
- each time exec is called, it runs the file anew as though we had pasted it in at the place where exec is called. 
- exec does not require module reloads after file changes. it skips the normal import logic.
- exec has the potential to silently overwrite variables we may currently be using.
- for contrast, import runs the file only once per process, and it makes the file a separate module namespace so that its assignments will not change variables in our scope.

Exceptions

An indication of erros. 

When an error occurs in the Python shell, it prints out some details about the exception and how it happened, which are called **unhandled exceptions**. 
- if there is no code to handle the exceptions, the program comes to a halt. 

Python functions don't declare what kind of exceptions they might raise and it's up to us to decide what possible exceptions we need to catch.

Sometimes we can anticipate what exception might occur. If we know what line of code may raise an exception, we can handle the exception use a try...except block. (like try-catch)

---

#### Object types


Everything in Python is an object.

dir function will return a list of all the attributes available for a given object. 

Common objects: 
| Object Type | Example |
---|---
Numbers | 1234, 3.1415, 3+4j, Decimal, Fraction
Strings | 'python', "Jupiter's", b'a\x01c'
Lists | [1, [2, 'three'], 4]
Dictionaries | {'Apple': 'iPhone', 'Google': 'Android'}
Tuples | {1, 'php', 3, 'Y'}
Files | myFile = open('java', 'r')
Sets | set('xyz'), {'x', 'y', 'z'}
Other core types | Booleans, types, None
Program unit types | Functions, modules, classes
Implementation related types | Compiled code, stack tracebacks

There are no type declarations in Python. The syntax of the expression determines the types of objects we create and use. 

Every value has a datatype, but we don't need to declare the datatyope of variables.

Can print objects either with full precision or in a user-friendly form. 
- Full precision = repr
- User-friendly = str

In Python 3.2, user-friendly is default(?)

Useful math modules:
```
>>> import math
>>> math.pi
3.141592653589793
>>> math.sqrt(1000)
31.622776601683793
>>> 
>>> import random
>>> random.random()
0.4245390260050892
>>> random.choice([1,2,3,4,5])
3
```

Sequence ---> Ordered collection of objects. 
- Maintain a left-to-right order
- Items are stored and fetched by their relative position

Strings support operations that assume positional ordering among items.
- len ---> get length of string
- indexing ---> grab certain characters.

```
>>> K = 'Keyboard'
>>> len(K)
8
>>> K[3]
'b'
>>> K[6]
'r'
```

Indexing backwards:
```
>>> K[-3]
'a'
>>> K[-2]
'r'
>>> K[-6]
'y'
>>> K[len(K)-2]
'r'
```

Index slicing:
- format: K[v:y] ---> give me everything in K from offset v up to but not including offest y
- this slices out (parse out) the characters in the middle. 

```
>>> K
'Keyboard'
>>> K[1:]
'eyboard'
>>> K[0:8]
'Keyboard'
>>> K[0:7]
'Keyboar'
>>> K[:7]
'Keyboar'
>>> K[:-1]
'Keyboar'
```

Every string operation produces a new string as a result.
- This is called **Immutability**

In Python, strings are immutable. Meaning they cannot be changed in-place after they are created. You can't change a string by assigning to one of its positions. Instead you can build a new string and assign it to the same name. 
- Python cleans up old objects as we go

(Immutable ---> cannot be changed)

example:
```
>>> K = 'Keyboard'
>>> K
'Keyboard'
>>> K[2]='U'
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'str' object does not support item assignment
>>> K = 'U' + K[1:]
>>> K
'Ueyboard'
```

- Immutability can be used to guarantee that an object remains constant throughout our program

find ---> substring search operation

replace ---> global search and replace

example:
```
>>> K = "Keyboard"
>>> K
'Keyboard'
>>> K.find('ar')
5
>>> K
'Keyboard'
>>> K.replace('ar','zz')
'Keybozzd'
>>> K
'Keyboard'
```
- K did not change to 'Keybozzd' because strings are immutable.


other string methods:
- line ---> split a string based on a delimiter into a list of substrings
  ```
  >>> colors = 'red,white,green,blue,purple'
  >>> colors
  'red,white,green,blue,purple'
  >>> colors.split(',')
  ['red', 'white', 'green', 'blue', 'purple']
  >>> shapes = 'star;circle;square;hexagon;octagon'
  >>> shapes
  'star;circle;square;hexagon;octagon'
  >>> shapes.split(';')
  ['star', 'circle', 'square', 'hexagon', 'octagon'] 
  ``` 
- upper, lower ---> upper case and lower case conversion
  ```
  >>> K = 'Keyboard'
  >>> K.upper()
  'KEYBOARD'
  >>> K.lower()
  'keyboard'
  ```
- isalpha() ---> test for alphanumerics
- isdigit() ---> tests for digits
- rstrip() ---> removes whitespace characters

dir() will give you method names:
```
>>> dir(K)
['__add__', '__class__', '__contains__', '__delattr__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__getslice__', '__gt__', '__hash__', '__init__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '_formatter_field_name_split', '_formatter_parser', 'capitalize', 'center', 'count', 'decode', 'encode', 'endswith', 'expandtabs', 'find', 'format', 'index', 'isalnum', 'isalpha', 'isdigit', 'islower', 'isspace', 'istitle', 'isupper', 'join', 'ljust', 'lower', 'lstrip', 'partition', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']
```
- names without underscores are the callable methods on string objects. 

To get information about what the methods actually do, use the help() function:
```
>>> help(K.swapcase)
Help on built-in function swapcase:

swapcase(...)
    S.swapcase() -> string

    Return a copy of the string S with uppercase characters
    converted to lowercase and vice versa.
```

**None** is a special constant in Python.
- It is a Null value
- Also the same as False
- It is the only Null value
- Datatype = NoneType
- You can assign None to any variable, but you cannot create other NoneType objects
- Comparing None to anything other than None will always return False
- All variables whose value is None are equal to each other
- DOES NOT EQUAL 0
- NOT AN EMPTY STRING
```
>>> type(None)

>>> None == 0
False
>>> None == ''
False
>>> None == False
False
>>> None == None
True
>>> a = None
>>> a == None
True
>>> b = None
>>> a == b
True
```

---

#### Python String

Python has 2 built-in types of strings
- **str** holds bytes
- **unicode** holds Unicode characters

**Python 3.x does not have a special Unicode string/type class, meaning every string is a Unicode string**

String Literals
```
>>> # Single quotes
>>> print('P"casso')
P"casso

>>> # Double quotes
>>> print("P'casso")
P'casso

>>> # Tripple quotes
>>> print('''...Picasso...''')
...Picasso...

>>> # Escape sequences
>>> print("P\ti\nca\Osso")
P	i
ca\Osso

>>> #Raw strings
>>> print(r"C:\myscript.py")
C:\myscript.py

>>> # Byte strings
>>> print(b'Picas\x01so')
b'Picas\x01so'
>>> type(b'Picas\x01so')
<class 'bytes'>
>>> type('normal_string')
<class 'str'>

>>> # Unicode strings
>>> S = 'A\u00c4B\U000000e8C'
>>> S
'A-B-C'
>>> len(S)
5
>>> 
```

#### Escape sequences
A backslash is used to introduce an escape sequence
- \n ---> new line
- \t ---> tab 

example:
```
>>> p = 'f\nir\te'
>>> p
'f\nir\te'
>>> print(p)
f
ir	e
```

| Escape | Meaning
---|---
\\\ | Backslash (stores one \)
\\` | Single quotes (stores ')
\\" | Double quotes (stores ")
\\a | Bell
\\b | Backspace
\\f | Formfeed
\\n | Newline
\\r | Carriage return
\\t | Horizontal tab
\\v | Vertical tab
\\xhh | Character with hex value hh (at most 2 digits)
\\ooo | Character with octal value ooo (up to 3 digits)
\\0 | Null: binary 0 character (doesn't end string)
\\N{ id } | Unicode database ID
\\uhhhh | Unicode 16-bit hex
\\Uhhhhhhhh | Unicode 32-bit hex
\\other | Not an escape (keeps both \ and other)

