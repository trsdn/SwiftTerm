//
//  CharSets.swift
//  SwiftTerm
//
//  Created by Miguel de Icaza on 3/1/20.
//  Copyright © 2020 Miguel de Icaza. All rights reserved.
//

import Foundation

class CharSets {
    public static let all: [UInt8:[UInt8:String]] = initAll ()
    
    // Multi-byte charset designators (e.g., ESC ( % 6 for Portuguese)
    // Keyed by the secondary prefix + charset byte (e.g., "%" + "6")
    public static let multiByte: [UInt16:[UInt8:String]] = initMultiByte ()
    
    // This is the "B" charset, null
    public static var defaultCharset: [UInt8:String]? = nil
    
    static func initAll () -> [UInt8:[UInt8:String]]
    {
        var all: [UInt8:[UInt8:String]] = [:]
        
        //
        // DEC Special Character and Line Drawing Set.
        // Reference: http://vt100.net/docs/vt102-ug/table5-13.html
        // A lot of curses apps use this if they see TERM=xterm.
        // testing: echo -e '\e(0a\e(B'
        // The xterm output sometimes seems to conflict with the
        // reference above. xterm seems in line with the reference
        // when running vttest however.
        // The table below now uses xterm's output from vttest.
        //
        all [Character("0").asciiValue!] = [
            Character("`").asciiValue!: "\u{25c6}",// '◆'
            Character("a").asciiValue!: "\u{2592}", // '▒'
            Character("b").asciiValue!: "\u{2409}", // [ht]
            Character("c").asciiValue!: "\u{240c}", // [ff]
            Character("d").asciiValue!: "\u{240d}", // [cr]
            Character("e").asciiValue!: "\u{240a}", // [lf]
            Character("f").asciiValue!: "\u{00b0}", // '°'
            Character("g").asciiValue!: "\u{00b1}", // '±'
            Character("h").asciiValue!: "\u{2424}", // [nl]
            Character("i").asciiValue!: "\u{240b}", // [vt]
            Character("j").asciiValue!: "\u{2518}", // '┘'
            Character("k").asciiValue!: "\u{2510}", // '┐'
            Character("l").asciiValue!: "\u{250c}", // '┌'
            Character("m").asciiValue!: "\u{2514}", // '└'
            Character("n").asciiValue!: "\u{253c}", // '┼'
            Character("o").asciiValue!: "\u{23ba}", // '⎺'
            Character("p").asciiValue!: "\u{23bb}", // '⎻'
            Character("q").asciiValue!: "\u{2500}", // '─'
            Character("r").asciiValue!: "\u{23bc}", // '⎼'
            Character("s").asciiValue!: "\u{23bd}", // '⎽'
            Character("t").asciiValue!: "\u{251c}", // '├'
            Character("u").asciiValue!: "\u{2524}", // '┤'
            Character("v").asciiValue!: "\u{2534}", // '┴'
            Character("w").asciiValue!: "\u{252c}", // '┬'
            Character("x").asciiValue!: "\u{2502}", // '│'
            Character("y").asciiValue!: "\u{2264}", // '≤'
            Character("z").asciiValue!: "\u{2265}", // '≥'
            Character("{").asciiValue!: "\u{03c0}", // 'π{'
            Character("|").asciiValue!: "\u{2260}", // '≠'
            Character("}").asciiValue!: "\u{00a3}", // '£{'
            Character("~").asciiValue!: "\u{00b7}"  // '·'
        ]
        
        // (DEC Alternate character ROM special graphics)
        all [Character("2").asciiValue!] = all [Character("0").asciiValue!]
        
        /**
         * British character set
         * ESC (A
         * Reference: http://vt100.net/docs/vt220-rm/table2-5.html
         */
        all [Character("A").asciiValue!] = [
            Character("#").asciiValue!: "£"
        ]
        
        /**
         * United States character set
         * ESC (B
         */
        all [Character("B").asciiValue!] = [:]
        
        /**
        * Dutch character set
        * ESC (4
        * Reference: http://vt100.net/docs/vt220-rm/table2-6.html
        */
        all [Character("4").asciiValue!] = [
            Character("#").asciiValue!: "£",
            Character("@").asciiValue!: "¾",
            Character("[").asciiValue!: "ĳ",
            Character("\\").asciiValue!: "½",
            Character("]").asciiValue!: "|",
            Character("{").asciiValue!: "¨",
            Character("|").asciiValue!: "f",
            Character("}").asciiValue!: "¼",
            Character("~").asciiValue!: "´"
        ]
        
        /**
         * Finnish character set
         * ESC (C or ESC (5
         * Reference: http://vt100.net/docs/vt220-rm/table2-7.html
         */
        all [Character("5").asciiValue!] = [
            Character("[").asciiValue!: "Ä",
            Character("\\").asciiValue!: "Ö",
            Character("]").asciiValue!: "Å",
            Character("^").asciiValue!: "Ü",
            Character("`").asciiValue!: "é",
            Character("{").asciiValue!: "ä",
            Character("|").asciiValue!: "ö",
            Character("}").asciiValue!: "å",
            Character("~").asciiValue!: "ü"
        ]
        all [Character("C").asciiValue!] = all [Character("5").asciiValue!]

        /**
        * French character set
        * ESC (R
        * Reference: http://vt100.net/docs/vt220-rm/table2-8.html
        */
        all [Character("R").asciiValue!] = [
            Character("#").asciiValue!: "£",
            Character("@").asciiValue!: "à",
            Character("[").asciiValue!: "°",
            Character("\\").asciiValue!: "ç",
            Character("]").asciiValue!: "§",
            Character("{").asciiValue!: "é",
            Character("|").asciiValue!: "ù",
            Character("}").asciiValue!: "è",
            Character("~").asciiValue!: "¨"
        ]
        
        /**
         * French Canadian character set
         * ESC (Q
         * Reference: http://vt100.net/docs/vt220-rm/table2-9.html
         */
        all [Character("Q").asciiValue!] = [
            Character("@").asciiValue!: "à",
            Character("[").asciiValue!: "â",
            Character("\\").asciiValue!: "ç",
            Character("]").asciiValue!: "ê",
            Character("^").asciiValue!: "î",
            Character("`").asciiValue!: "ô",
            Character("{").asciiValue!: "é",
            Character("|").asciiValue!: "ù",
            Character("}").asciiValue!: "è",
            Character("~").asciiValue!: "û"
        ]
        
        /**
         * German character set
         * ESC (K
         * Reference: http://vt100.net/docs/vt220-rm/table2-10.html
         */
        all [Character("K").asciiValue!] = [
            Character("@").asciiValue!: "§",
            Character("[").asciiValue!: "Ä",
            Character("\\").asciiValue!: "Ö",
            Character("]").asciiValue!: "Ü",
            Character("{").asciiValue!: "ä",
            Character("|").asciiValue!: "ö",
            Character("}").asciiValue!: "ü",
            Character("~").asciiValue!: "ß"
        ]
        
        /**
         * Italian character set
         * ESC (Y
         * Reference: http://vt100.net/docs/vt220-rm/table2-11.html
         */
        all [Character("Y").asciiValue!] = [
            Character("#").asciiValue!: "£",
            Character("@").asciiValue!: "§",
            Character("[").asciiValue!: "°",
            Character("\\").asciiValue!: "ç",
            Character("]").asciiValue!: "é",
            Character("`").asciiValue!: "ù",
            Character("{").asciiValue!: "à",
            Character("|").asciiValue!: "ò",
            Character("}").asciiValue!: "è",
            Character("~").asciiValue!: "ì"
        ]
    
        /**
         * Norwegian/Danish character set
         * ESC (E or ESC (6
         * Reference: http://vt100.net/docs/vt220-rm/table2-12.html
         */
        all [Character("6").asciiValue!] = [
            Character("@").asciiValue!: "Ä",
            Character("[").asciiValue!: "Æ",
            Character("\\").asciiValue!: "Ø",
            Character("]").asciiValue!: "Å",
            Character("^").asciiValue!: "Ü",
            Character("`").asciiValue!: "ä",
            Character("{").asciiValue!: "æ",
            Character("|").asciiValue!: "ø",
            Character("}").asciiValue!: "å",
            Character("~").asciiValue!: "ü"
        ]
        all [Character("E").asciiValue!] = all [Character("6").asciiValue!]
        
        /**
         * Spanish character set
         * ESC (Z
         * Reference: http://vt100.net/docs/vt220-rm/table2-13.html
         */
        all [Character("Z").asciiValue!] = [
            Character("#").asciiValue!: "£",
            Character("@").asciiValue!: "§",
            Character("[").asciiValue!: "¡",
            Character("\\").asciiValue!: "Ñ",
            Character("]").asciiValue!: "¿",
            Character("{").asciiValue!: "°",
            Character("|").asciiValue!: "ñ",
            Character("}").asciiValue!: "ç"
        ]

        /**
         * Swedish character set
         * ESC (H or ESC (7
         * Reference: http://vt100.net/docs/vt220-rm/table2-14.html
         */
        all [Character("7").asciiValue!] = [
            Character("@").asciiValue!: "É",
            Character("[").asciiValue!: "Ä",
            Character("\\").asciiValue!: "Ö",
            Character("]").asciiValue!: "Å",
            Character("^").asciiValue!: "Ü",
            Character("`").asciiValue!: "é",
            Character("{").asciiValue!: "ä",
            Character("|").asciiValue!: "ö",
            Character("}").asciiValue!: "å",
            Character("~").asciiValue!: "ü"
        ]
        all [Character("H").asciiValue!] = all [Character("7").asciiValue!]
        
        /**
         * Swiss character set
         * ESC (=
         * Reference: http://vt100.net/docs/vt220-rm/table2-15.html
         */
        all [Character("=").asciiValue!] = [
            Character("#").asciiValue!: "ù",
            Character("@").asciiValue!: "à",
            Character("[").asciiValue!: "é",
            Character("\\").asciiValue!: "ç",
            Character("]").asciiValue!: "ê",
            Character("^").asciiValue!: "î",
            Character("_").asciiValue!: "è",
            Character("`").asciiValue!: "ô",
            Character("{").asciiValue!: "ä",
            Character("|").asciiValue!: "ö",
            Character("}").asciiValue!: "ü",
            Character("~").asciiValue!: "û"
        ]

        /**
         * DEC Technical character set
         * ESC (>
         * Reference: xterm charsets.c / VT330 Programmer Reference
         */
        all [Character(">").asciiValue!] = [
            Character("!").asciiValue!: "\u{23b7}",  // ⎷ RADICAL SYMBOL BOTTOM
            Character("\"").asciiValue!: "\u{250c}",  // ┌ BOX DRAWINGS LIGHT DOWN AND RIGHT
            Character("#").asciiValue!: "\u{2500}",  // ─ BOX DRAWINGS LIGHT HORIZONTAL
            Character("$").asciiValue!: "\u{2320}",  // ⌠ TOP HALF INTEGRAL
            Character("%").asciiValue!: "\u{2321}",  // ⌡ BOTTOM HALF INTEGRAL
            Character("&").asciiValue!: "\u{2502}",  // │ BOX DRAWINGS LIGHT VERTICAL
            Character("'").asciiValue!: "\u{23a1}",  // ⎡ LEFT SQUARE BRACKET UPPER CORNER
            Character("(").asciiValue!: "\u{23a3}",  // ⎣ LEFT SQUARE BRACKET LOWER CORNER
            Character(")").asciiValue!: "\u{23a4}",  // ⎤ RIGHT SQUARE BRACKET UPPER CORNER
            Character("*").asciiValue!: "\u{23a6}",  // ⎦ RIGHT SQUARE BRACKET LOWER CORNER
            Character("+").asciiValue!: "\u{23a7}",  // ⎧ LEFT CURLY BRACKET UPPER HOOK
            Character(",").asciiValue!: "\u{23a9}",  // ⎩ LEFT CURLY BRACKET LOWER HOOK
            Character("-").asciiValue!: "\u{23ab}",  // ⎫ RIGHT CURLY BRACKET UPPER HOOK
            Character(".").asciiValue!: "\u{23ad}",  // ⎭ RIGHT CURLY BRACKET LOWER HOOK
            Character("/").asciiValue!: "\u{23a8}",  // ⎨ LEFT CURLY BRACKET MIDDLE PIECE
            Character("0").asciiValue!: "\u{23ac}",  // ⎬ RIGHT CURLY BRACKET MIDDLE PIECE
            Character("?").asciiValue!: "\u{2260}",  // ≠ NOT EQUAL TO
            Character("O").asciiValue!: "\u{2261}",  // ≡ IDENTICAL TO
            Character("P").asciiValue!: "\u{2264}",  // ≤ LESS-THAN OR EQUAL TO
            Character("Q").asciiValue!: "\u{2265}",  // ≥ GREATER-THAN OR EQUAL TO
            Character("R").asciiValue!: "\u{222b}",  // ∫ INTEGRAL
            Character("S").asciiValue!: "\u{2234}",  // ∴ THEREFORE
            Character("T").asciiValue!: "\u{221d}",  // ∝ PROPORTIONAL TO
            Character("U").asciiValue!: "\u{221e}",  // ∞ INFINITY
            Character("V").asciiValue!: "\u{00f7}",  // ÷ DIVISION SIGN
            Character("W").asciiValue!: "\u{0394}",  // Δ GREEK CAPITAL LETTER DELTA
            Character("X").asciiValue!: "\u{2207}",  // ∇ NABLA
            Character("Y").asciiValue!: "\u{03a6}",  // Φ GREEK CAPITAL LETTER PHI
            Character("Z").asciiValue!: "\u{0393}",  // Γ GREEK CAPITAL LETTER GAMMA
            Character("[").asciiValue!: "\u{223c}",  // ∼ TILDE OPERATOR
            Character("\\").asciiValue!: "\u{2243}",  // ≃ ASYMPTOTICALLY EQUAL TO
            Character("]").asciiValue!: "\u{0398}",  // Θ GREEK CAPITAL LETTER THETA
            Character("^").asciiValue!: "\u{00d7}",  // × MULTIPLICATION SIGN
            Character("_").asciiValue!: "\u{039b}",  // Λ GREEK CAPITAL LETTER LAMDA
            Character("`").asciiValue!: "\u{21d4}",  // ⇔ LEFT RIGHT DOUBLE ARROW
            Character("a").asciiValue!: "\u{21d2}",  // ⇒ RIGHTWARDS DOUBLE ARROW
            Character("b").asciiValue!: "\u{2228}",  // ∨ LOGICAL OR
            Character("c").asciiValue!: "\u{2227}",  // ∧ LOGICAL AND
            Character("d").asciiValue!: "\u{2203}",  // ∃ THERE EXISTS
            Character("e").asciiValue!: "\u{2200}",  // ∀ FOR ALL
            Character("f").asciiValue!: "\u{2135}",  // ℵ ALEF SYMBOL
            Character("g").asciiValue!: "\u{039e}",  // Ξ GREEK CAPITAL LETTER XI
            Character("h").asciiValue!: "\u{03a8}",  // Ψ GREEK CAPITAL LETTER PSI
            Character("i").asciiValue!: "\u{03a9}",  // Ω GREEK CAPITAL LETTER OMEGA
            Character("j").asciiValue!: "\u{03a0}",  // Π GREEK CAPITAL LETTER PI
            Character("k").asciiValue!: "\u{03a3}",  // Σ GREEK CAPITAL LETTER SIGMA
            Character("n").asciiValue!: "\u{2282}",  // ⊂ SUBSET OF
            Character("o").asciiValue!: "\u{2283}",  // ⊃ SUPERSET OF
            Character("p").asciiValue!: "\u{2229}",  // ∩ INTERSECTION
            Character("q").asciiValue!: "\u{222a}",  // ∪ UNION
            Character("r").asciiValue!: "\u{2227}",  // ∧ LOGICAL AND
            Character("s").asciiValue!: "\u{2228}",  // ∨ LOGICAL OR
            Character("t").asciiValue!: "\u{00ac}",  // ¬ NOT SIGN
            Character("u").asciiValue!: "\u{03b1}",  // α GREEK SMALL LETTER ALPHA
            Character("v").asciiValue!: "\u{03b2}",  // β GREEK SMALL LETTER BETA
            Character("w").asciiValue!: "\u{03c7}",  // χ GREEK SMALL LETTER CHI
            Character("x").asciiValue!: "\u{03b4}",  // δ GREEK SMALL LETTER DELTA
            Character("y").asciiValue!: "\u{03b5}",  // ε GREEK SMALL LETTER EPSILON
            Character("z").asciiValue!: "\u{03c6}",  // φ GREEK SMALL LETTER PHI
            Character("{").asciiValue!: "\u{03b3}",  // γ GREEK SMALL LETTER GAMMA
            Character("|").asciiValue!: "\u{03b7}",  // η GREEK SMALL LETTER ETA
            Character("}").asciiValue!: "\u{03b9}",  // ι GREEK SMALL LETTER IOTA
            Character("~").asciiValue!: "\u{03c3}"   // σ GREEK SMALL LETTER SIGMA
        ]

        return all
    }
    
    /// Helper to create a UInt16 key from two bytes for multi-byte charset designators
    static func multiByteKey(_ prefix: UInt8, _ code: UInt8) -> UInt16 {
        return UInt16(prefix) << 8 | UInt16(code)
    }
    
    static func initMultiByte () -> [UInt16:[UInt8:String]]
    {
        var mb: [UInt16:[UInt8:String]] = [:]
        
        /**
         * Portuguese character set
         * ESC (% 6
         * Reference: xterm charsets.h / VT520 manual
         */
        mb [multiByteKey(Character("%").asciiValue!, Character("6").asciiValue!)] = [
            Character("[").asciiValue!: "Ã",
            Character("\\").asciiValue!: "Ç",
            Character("]").asciiValue!: "Õ",
            Character("{").asciiValue!: "ã",
            Character("|").asciiValue!: "ç",
            Character("}").asciiValue!: "õ"
        ]
        
        /**
         * Turkish character set
         * ESC (% 2
         * Reference: xterm charsets.h / VT520 manual
         */
        mb [multiByteKey(Character("%").asciiValue!, Character("2").asciiValue!)] = [
            Character("&").asciiValue!: "\u{011f}",  // ğ LATIN SMALL LETTER G WITH BREVE
            Character("@").asciiValue!: "\u{0130}",  // İ LATIN CAPITAL LETTER I WITH DOT ABOVE
            Character("[").asciiValue!: "\u{015e}",  // Ş LATIN CAPITAL LETTER S WITH CEDILLA
            Character("\\").asciiValue!: "\u{00d6}",  // Ö LATIN CAPITAL LETTER O WITH DIAERESIS
            Character("]").asciiValue!: "\u{00c7}",  // Ç LATIN CAPITAL LETTER C WITH CEDILLA
            Character("^").asciiValue!: "\u{00dc}",  // Ü LATIN CAPITAL LETTER U WITH DIAERESIS
            Character("`").asciiValue!: "\u{011e}",  // Ğ LATIN CAPITAL LETTER G WITH BREVE
            Character("{").asciiValue!: "\u{015f}",  // ş LATIN SMALL LETTER S WITH CEDILLA
            Character("|").asciiValue!: "\u{00f6}",  // ö LATIN SMALL LETTER O WITH DIAERESIS
            Character("}").asciiValue!: "\u{00e7}",  // ç LATIN SMALL LETTER C WITH CEDILLA
            Character("~").asciiValue!: "\u{00fc}"   // ü LATIN SMALL LETTER U WITH DIAERESIS
        ]
        
        return mb
    }
}
