context("Question 1: text_shortener")

test_that(desc = "Does the function text_shortener exist?",
          code = {
               expect( exists("text_shortener"),
                       failure_message = "No function found with that name.")
           })

test_that(desc = "Does it run and return a short input?",
          code = {
               expect_equal(object   = text_shortener("asdf"),
                            expected = "asdf")
           })

test_that(desc = "Replace multiple consecutive spaces by a single space: fish",
          code = {
               expect_equal(object   = text_shortener("red   fish blue fish"),
                            expected = "red fish blue fish")
           })

test_that(desc = "Replace multiple consecutive spaces by a single space: hello",
          code = {
               expect_equal(object   = text_shortener("Hello   world!"),
                            expected = "Hello world!")
           })

test_that(desc = "Replace multiple consecutive spaces by a single space: ants are best",
          code = {

               expect_equal(object   = text_shortener("Yes  maam  ants  are  best  sir."),
                            expected = "Yes maam ants are best sir.")
           })

test_that(desc = "Abbreviate words longer than 5 characters (i.e. replace the additional characters by a '.'): Lala",
          code = {
               expect_equal(object   = text_shortener("Lalalalalalalalala"),
                            expected = "Lalal.")
           })

test_that(desc = "Abbreviate words longer than 5 characters (i.e. replace the additional characters by a '.'): elephant",
          code = {
               expect_equal(object   = text_shortener("Superfragilistic elephant"),
                            expected = "Super. eleph.")
           })

test_that(desc = "Abbreviate words longer than 5 characters (i.e. replace the additional characters by a '.'): expectation",
          code = {
               expect_equal(object   = text_shortener("Expectation, anticipation, gravity & hope."),
                            expected = "Expec., antic., gravi. & hope.")
           })


test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
               expect_equal(object   = text_shortener("We go hard or we go home We gon do this all very night long"),
                            expected = "We go hard or we go home We gon do this all night long")
           })

test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
              expect_equal(object   = text_shortener("Say hello to the world the big world"),
                           expected = "Say hello to world big world")
          })

test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
              expect_equal(object   = text_shortener("The really big ants are truly cool and easy to look at."),
                           expected = "Big ants are cool and easy to look at.")
           })

test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              expect_equal(object   = text_shortener("Long hair. Long life."),
                           expected = "Long hair.")
          })
test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              expect_equal(object   = text_shortener("I - confine myself to one special difficulty, which at first appeared to me insuperable, and actually fatal to my whole theory. I allude to the neuters or sterile females in insect-communities: for these neuters often differ widely in instinct and in structure from both the males and fertile females, and yet, from being sterile, they cannot propagate their kind. The subject well deserves to be discussed at great length, but I will here take only a single case, that of working or sterile ants."),
                           expected = "I - confi. mysel. to one speci. diffi., which at first appea. to me insup., and actua. fatal to my whole theory.")
          })

test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              big_text <- paste("Les sangl longs des violo de l autom. Bless mon coeur dune lang monot. Tout suffo et bleme.",
                                "Quand sonne lheur, je me souvi des jours ancie. Et je pleur. Au vent mauve qui mempr. Deca dela. Parei a la feuil mort.",
                                sep = "\n")
              expected_shortened_text <- paste("Les sangl longs des violo de l autom.", "Quand sonne lheur, je me souvi des jours ancie.", sep = "\n")
              expect_equal(object   = text_shortener(big_text),
                            expected = expected_shortened_text)

          })
