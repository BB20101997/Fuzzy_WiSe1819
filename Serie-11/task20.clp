Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Jan 27, 2019 3:08:27 PM java.util.jar.Attributes read
WARNING: Duplicate name in Manifest: Depends-On.
Ensure that the manifest does not have duplicate entries, and
that blank lines separate individual sections in both your
manifest and in the META-INF/MANIFEST.MF entry in the jar file.
Benutze CLP-Datei: FuzzyShowerJess.clp
;; Diese Datei ist unvollstaendig
;;

(defglobal ?*tempFvar* = (new nrc.fuzzy.FuzzyVariable 
                          "temperature" 5.0 65.0 "Degrees C"))
(defglobal ?*flowFvar* = (new nrc.fuzzy.FuzzyVariable "flow" 
                          0.0 100.0 "litres/minute"))
(defglobal ?*coldValveChangeFvar* = 
                         (new nrc.fuzzy.FuzzyVariable "coldValveChange" -1.0 1.0 ""))
(defglobal ?*hotValveChangeFvar* = 
                         (new nrc.fuzzy.FuzzyVariable "hotValveChange" -1.0 1.0 ""))
(defglobal ?*rlf* = (new nrc.fuzzy.RightLinearFunction))
(defglobal ?*llf* = (new nrc.fuzzy.LeftLinearFunction))

(defglobal ?*rulesThatFired* = "")


(defrule init
   (declare (salience 100))
  =>
   (import nrc.fuzzy.*)
   (load-package nrc.fuzzy.jess.FuzzyFunctions)

   (?*tempFvar* addTerm "none" (new RFuzzySet 5.0 5.1 ?*rlf*))
   (?*tempFvar* addTerm "cold" (new TrapezoidFuzzySet 5.0 6.0 25.0 34.5))
   (?*tempFvar* addTerm "OK"   (new PIFuzzySet 36.0 2.5))
   (?*tempFvar* addTerm "warm" (new SFuzzySet 37.5 65.0))

   ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   ;; hier sollen Fuzzy Sets fuer die Variable 'tempFvar ' angegeben werden.
   ;; (Tipp: sehr aehnlich wie fuer die untere 'flowFvar') 
   ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   
   
   (?*flowFvar* addTerm "none"   (new RFuzzySet 0.0 0.05 ?*rlf*))
   (?*flowFvar* addTerm "low"    (new TrapezoidFuzzySet 0.0 0.025 3.0 11.5))
   (?*flowFvar* addTerm "OK"     (new PIFuzzySet 12.0 1.8))
   (?*flowFvar* addTerm "strong" (new SFuzzySet 12.5 25.0))


   ;; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   ;; hier sollen Fuzzy Sets fuer die Variablen 'hotValveChangeFvar' und 
   ;; 'coldValveChangeFvar' angegeben werden
   ;; z.B.:
   ;; (?*coldValveChangeFvar* addTerm "Z" (new TriangleFuzzySet -.05 0.0 0.05))
   ;; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   (?*coldValveChangeFvar* addTerm "Z"  (new TriangleFuzzySet -0.05  0.0    0.05))
   (?*coldValveChangeFvar* addTerm "NS" (new TriangleFuzzySet -0.25 -0.2   -0.15))
   (?*coldValveChangeFvar* addTerm "PS" (new TriangleFuzzySet  0.15  0.2    0.25))
   (?*coldValveChangeFvar* addTerm "NM" (new TriangleFuzzySet -0.55 -0.5   -0.45))
   (?*coldValveChangeFvar* addTerm "PM" (new TriangleFuzzySet  0.45  0.5    0.55))
   (?*coldValveChangeFvar* addTerm "NB" (new TriangleFuzzySet -1.00 -0.95  -0.9 ))
   (?*coldValveChangeFvar* addTerm "PB" (new TriangleFuzzySet  0.9   0.95   1.00))
   
   (?*hotValveChangeFvar* addTerm "Z"  (new TriangleFuzzySet -0.05   0.0    0.05))
   (?*hotValveChangeFvar* addTerm "NS" (new TriangleFuzzySet -0.25  -0.2   -0.15))
   (?*hotValveChangeFvar* addTerm "PS" (new TriangleFuzzySet  0.15   0.2    0.25))
   (?*hotValveChangeFvar* addTerm "NM" (new TriangleFuzzySet -0.55  -0.5   -0.45))
   (?*hotValveChangeFvar* addTerm "PM" (new TriangleFuzzySet  0.4    0.5    0.55))
   (?*hotValveChangeFvar* addTerm "NB" (new TriangleFuzzySet -1.00  -0.95  -0.9 ))
   (?*hotValveChangeFvar* addTerm "PB" (new TriangleFuzzySet  0.9    0.95   1.00))
 
   (store TEMPFUZZYVARIABLE ?*tempFvar*)
   (store FLOWFUZZYVARIABLE ?*flowFvar*)
)

;; diese Regel ist noetig beim erstmaligen Start
(defrule none_none
  (temp ?t&:(fuzzy-match ?t "none"))
  (flow ?f&:(fuzzy-match ?f "none"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "PB"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "PM"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp none and Flow none then 
    change Hot Valve PB and change Cold Valve PM fires%")
  )
)

(defrule warm_low
  (temp ?t&:(fuzzy-match ?t "warm"))
  (flow ?f&:(fuzzy-match ?f "low"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "Z"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "PB"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp warm and Flow low then 
    change Hot Valve Z and change Cold Valve PM fires%")
  )
)


(defrule OK_OK
  (temp ?t&:(fuzzy-match ?t "OK"))
  (flow ?f&:(fuzzy-match ?f "OK"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "Z"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "Z"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp OK and Flow OK then 
    change Hot Valve Z and change Cold Valve Z fires%")
  )
)

(defrule warm_OK
  (temp ?t&:(fuzzy-match ?t "warm"))
  (flow ?f&:(fuzzy-match ?f "OK"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "NM"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "PM"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp warm and Flow OK then 
    change Hot Valve NM and change Cold Valve PM fires%")
  )
)

(defrule warm_strong
  (temp ?t&:(fuzzy-match ?t "warm"))
  (flow ?f&:(fuzzy-match ?f "strong"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "NB"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "Z"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp warm and Flow Z then 
    change Hot Valve NM and change Cold Valve Z fires%")
  )
)

(defrule OK_strong
  (temp ?t&:(fuzzy-match ?t "OK"))
  (flow ?f&:(fuzzy-match ?f "strong"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "NM"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "NM"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp OK and Flow strong then 
    change Hot Valve NS and change Cold Valve NS fires%")
  )
)


(defrule cold_low
(temp ?t&:(fuzzy-match ?t "cold"))
(flow ?f&:(fuzzy-match ?f "low"))
=>
(assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "PB"))
  (change_cv (new FuzzyValue ?*coldValveChangeFvar* "Z"))
)
(bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
"!Rule: if Temp cold and Flow low then 
change Hot Valve PM and change Cold Valve Z fires%")
)
)


(defrule cold_OK
(temp ?t&:(fuzzy-match ?t "cold"))
(flow ?f&:(fuzzy-match ?f "OK"))
=>
(assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "PM"))
  (change_cv (new FuzzyValue ?*coldValveChangeFvar* "NM"))
)
(bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
"!Rule: if Temp cold and Flow OK then 
change Hot Valve PS and change Cold Valve PM fires%")
)
)

(defrule cold_strong
(temp ?t&:(fuzzy-match ?t "cold"))
(flow ?f&:(fuzzy-match ?f "strong"))
=>
(assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "Z"))
  (change_cv (new FuzzyValue ?*coldValveChangeFvar* "NB"))
)
(bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
"!Rule: if Temp clod and Flow strong then 
change Hot Valve Z and change Cold Valve NM fires%")
)
)

(defrule OK_low
  (temp ?t&:(fuzzy-match ?t "OK"))
  (flow ?f&:(fuzzy-match ?f "low"))
 =>
  (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "PM"))
          (change_cv (new FuzzyValue ?*coldValveChangeFvar* "PM"))
  )
  (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   "!Rule: if Temp OK and Flow low then 
    change Hot Valve PS and change Cold Valve PS fires%")
  )
)

   ;; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   ;; Erzeuge alle notwendigen Regeln analog dem Beispiel fuer 
   ;; die Regel 'cold_low':
   ;; +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   ;; (defrule cold_low
   ;; (temp ?t&:(fuzzy-match ?t "cold"))
   ;; (flow ?f&:(fuzzy-match ?f "low"))
   ;; =>
   ;; (assert (change_hv (new FuzzyValue ?*hotValveChangeFvar* "PB"))
   ;;        (change_cv (new FuzzyValue ?*coldValveChangeFvar* "Z"))
   ;; )
   ;; (bind ?*rulesThatFired* (str-cat ?*rulesThatFired*
   ;;  "!Rule: if Temp cold and Flow low then 
   ;;   change Hot Valve PB and change Cold Valve Z fires%")
   ;; )
   ;; )


;; Die Regel 'defuzzify' hat die niedrigste Prioritaet und uebergibt das Ergebnis 
;; an den Simulator

(defrule defuzzify "low salience to allow all rules to fire and do global contribution"
   (declare (salience -100))
  ?hf <- (change_hv ?h)
  ?cf <- (change_cv ?c)
  ?temp <- (temp ?)
  ?flow <- (flow ?)
 =>
  (bind ?hot-change (?h momentDefuzzify))
  (bind ?cold-change (?c momentDefuzzify))
  (store COLDVALVECHANGE ?cold-change)
  (store HOTVALVECHANGE ?hot-change)
  (store RULESTHATFIRED ?*rulesThatFired*)
  (bind ?*rulesThatFired* "")
  (retract ?hf ?cf ?temp ?flow)
)


