

(in-package "BITOPS")

(include-book "centaur/misc/context-rw" :dir :system)
(include-book "centaur/bitops/equal-by-logbitp" :dir :system)
(include-book "centaur/bitops/ihsext-basics" :dir :system)


(defthm logand-mask-of-logapp
  (implies (and (syntaxp (and (quotep n) (quotep m)))
                (equal (logtail m n) 0))
           (equal (logand n (logapp m a b))
                  (logand n a)))
  :hints((logbitp-reasoning :prune-examples nil)))


(defthm logbitp-induces-logand-context
  (implies (syntaxp (quotep n))
           (equal (logbitp n (logand (ash 1 (nfix n)) m))
                  (logbitp n m)))
  :hints ((logbitp-reasoning :prune-examples nil)))

(add-context-rule logbitp (:rewrite logbitp-induces-logand-context))

(defthm logior-passes-logand-context-1
  (implies (syntaxp (quotep n))
           (equal (logand n (logior (logand n a) b))
                  (logand n (logior a b))))
  :hints ((logbitp-reasoning)))

(defthm logior-passes-logand-context-2
  (implies (syntaxp (quotep n))
           (equal (logand n (logior a (logand n b)))
                  (logand n (logior a b))))
  :hints ((logbitp-reasoning)))

(defthm logand-passes-logand-context-1
  (implies (syntaxp (quotep n))
           (equal (logand n (logand (logand n a) b))
                  (logand n (logand a b))))
  :hints ((logbitp-reasoning)))

(defthm logand-passes-logand-context-2
  (implies (syntaxp (and (quotep n) (not (quotep a))))
           (equal (logand n (logand a (logand n b)))
                  (logand n (logand a b))))
  :hints ((logbitp-reasoning)))

(add-context-rule binary-logand (:rewrite logior-passes-logand-context-1))
(add-context-rule binary-logand (:rewrite logior-passes-logand-context-2))
(add-context-rule binary-logand (:rewrite logand-passes-logand-context-1))
(add-context-rule binary-logand (:rewrite logand-passes-logand-context-2))

(defthm logbitp-remove-logand-context
  (implies (and (syntaxp (quotep n))
                (int-equiv mask (ash 1 (nfix n))))
           (equal (logbitp n (logand mask m))
                  (logbitp n m)))
  :hints ((logbitp-reasoning :prune-examples nil)))


(defthm logbitp-of-logand-logior-logapp
  (Equal (logbitp 4 (logand (logior a b c (logapp 6 d e)) f g))
         (logbitp 4 (logand (logior a b c d) f g)))
  :hints(("Goal" :in-theory (disable logbitp-of-logand
                                     acl2::commutativity-of-logand
                                     bitops::commutativity-2-of-logand))))
