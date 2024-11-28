library(testthat)
context("Automatically testing the shorten_text function")


test_that(desc = "1. Does the function shorten_text exist?",
          code = {
            expect(exists("shorten_text"),
                   failure_message = "No function found with that name.")
          })

test_that(desc = "2. Does it run and appropriately return a short input unchanged?",
          code = {
            expect_equal(object   = shorten_text("asdf"),
                         expected = "asdf")
          })

test_that(desc = "3. Function handles sentence without changes or full stops appropriately",
          code = {
            text <- "This is a text with no full stops"
            expected <- "This is a text with no full stops"
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "4. Function returns an empty string when given an empty string",
          code = {
            expect_equal(shorten_text(""), "")
          })

test_that(desc = "5. Replace multiple consecutive spaces by a single space: fish",
          code = {
            expect_equal(object   = shorten_text("red   fish blue fish."),
                         expected = "red fish blue fish.")
          })

test_that(desc = "6. Multiple consecutive spaces are replaced by a single space",
          code = {
            text <- "This is  a  test    with     space."
            expected <- "This is a test with space."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "7. Replace multiple consecutive spaces by a single space and an exclamation",
          code = {
            text <- "Hello   world!"
            expected <- "Hello world!"
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "8. Replace multiple consecutive spaces by a single space: ants are best",
          code = {
            text <- "Yes  maam  ants  are  best  sir."
            expected <- "Yes maam ants are best sir."
            expect_equal(shorten_text(text), expected)
          })


test_that(desc = "9. Function does not abbreviate 5-character words",
          code = {
            text <- "Words like apple and water may stay."
            expected <- "Words like apple and water may stay."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "10. Abbreviate words longer than 5 chars (i.e. replace extra characters by a '.'): Lala",
          code = {
            text <- "Lalalalalalalalala"
            expected <- "Lalal."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "11. Words longer than 5 characters are abbreviated",
          code = {
            text <- "Programming in R is interesting."
            expected <- "Progr. in R is inter.."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "12. Abbreviate words longer than 5 chars (i.e. replace extra characters by a '.'): expectation",
          code = {
            text <- "Expectation, anticipation, gravity & hope."
            expected <- "Expec., antic., gravi. & hope."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "13. Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
            text <- "We go hard or we go home We gon do this all very night long"
            expected <- "We go hard or we go home We gon do this all night long"
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "14. Remove 'the'.",
          code = {
            test <- "Say hello to the big world"
            expected <- "Say hello to big world"
            expect_equal(shorten_text(test), expected)
          })

test_that(desc = "15. Remove 'the' (twice).",
          code = {
            test <- "Say hello to the world the big world"
            expected <- "Say hello to world big world"
            expect_equal(shorten_text(test), expected)
          })

test_that(desc = "16. Remove 'the' and 'very'; adjust spacing.",
          code = {
            test <- "Say hello to the world the very big world"
            expected <- "Say hello to world big world"
            expect_equal(shorten_text(test), expected)
          })

test_that(desc = "17. Remove: 'the', 'really', 'truly', 'very' and adjust space.",
          code = {
            text <- "Hey really truly very the bee you know me."
            expected <- "Hey bee you know me."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "18. Remove: 'really' at end of sentence",
          code = {
            text <- "I love R really."
            expected <- "I love R."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "19. Remove all of the following words: 'really', 'truly', 'very'.",
          code = {
            text <- "Really big ants are truly cool and really easy to look at."
            expected <- "Big ants are cool and easy to look at."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "20. Function abbreviates even if word has punctuation",
          code = {
           text <- "A functionality's details are specific."
           expected <- "A funct.'s detai. are speci.."
           expect_equal(shorten_text(text), expected)
          })

test_that(desc = "21. Understand that an exclamation mark ends a sentence",
          code = {
            text <- "Ah! I hate edge cases."
            expected <- "Ah!"
            expect_equal(shorten_text(text), expected)
          })


test_that(desc = "22. Specified words are removed, and capitalisation adjusted",
          code = {
            text <- "The sky is really blue and truly blue."
            expected <- "Sky is blue and blue."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "23. Function does not remove words that contain 'the' as substring",
          code = {
            text <- "Theme of the meeting was thermal energy."
            expected <- "Theme of meeti. was therm. energ.."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "24. Keep only the first sentence in every paragraph if one paragraph.",
          code = {
            expect_equal(object   = shorten_text("Long hair. Long life."),
                         expected = "Long hair.")
          })

test_that(desc = "25. Function handles single-word paragraphs",
          code = {
            text <- "Hello.\n\nWorld."
            expected <- "Hello.\n\nWorld."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "26. Function maintains paragraph structure with multiple spaces in one-sentence paragraphs.",
          code = {
            text <- "This is  a  test.    \n\nThis is only a   test with  space."
            expected <- "This is a test.\n\nThis is only a test with space."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "27. Keep only the first sentence in every paragraph, if multiple paragraphs are present.",
          code = {
            text <-
              "This is first one. This is second.\n\nThis is third. This is fourth."
            expected <- "This is first one.\n\nThis is third."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "28. Keep only the first sentence, when several other changes are made.",
          code = {
            text <-  "I - confine myself to one special difficulty, which at first appeared to me insuperable, and actually fatal to my whole theory. I allude to the neuters or sterile females in insect-communities: ... sterile ants."
            expected <- "I - confi. mysel. to one speci. diffi., which at first appea. to me insup., and actua. fatal to my whole theor.."
            expect_equal(shorten_text(text), expected)
          })

test_that(desc = "29. Keep only the first sentence in every paragraph when no other changes.",
          code = {
            text <-
              paste(
                "Les sangl longs des violo de l autom. Bless mon coeur dune lang monot. Tout suffo et bleme.",
                "Quand sonne lheur, je me souvi des jours ancie. Et je pleur. Au vent mauve qui mempr. Deca dela. Parei a la feuil mort.",
                sep = "\n"
              )
            expected <-
              paste(
                "Les sangl longs des violo de l autom.",
                "Quand sonne lheur, je me souvi des jours ancie.",
                sep = "\n"
              )
              expect_equal(shorten_text(text), expected)
          })

test_that(desc = "30. Function maintains special characters in text",
          code = {
            text <- "Wow: !@#$ are same same."
            expected <- "Wow: !@#$ are same same."
            expect_equal(shorten_text(text), expected)
          })
