library(testthat)
context("Question 1: shorten_text")

test_that(desc = "Does the function shorten_text exist?",
          code = {
               expect( exists("shorten_text"),
                       failure_message = "No function found with that name.")
           })

test_that(desc = "Does it run and appropriately return a short input unchanged?",
          code = {
               expect_equal(object   = shorten_text("asdf"),
                            expected = "asdf")
           })

test_that("Function handles text without full stops as single sentence", {
  text <- "This is a text with no full stops"
  expected <- "This is a text with no full stops"
  expect_equal(shorten_text(text), expected)
})

# Additional tests to handle edge cases
test_that("Function returns an empty string when given an empty string", {
  expect_equal(shorten_text(""), "")
})

test_that("Function handles single-word paragraphs", {
  text <- "Hello.\n\nWorld."
  expected <- "Hello.\n\nWorld."
  expect_equal(shorten_text(text), expected)
})

test_that(desc = "Replace multiple consecutive spaces by a single space: fish",
          code = {
               expect_equal(object   = shorten_text("red   fish blue fish."),
                            expected = "red fish blue fish.")
           })

test_that(desc = "Multiple consecutive spaces are replaced by a single space",
          code = {
               text <- "This is  a  test    with    many spaces."
               expected <- "This is a test with many spaces."
               expect_equal(shorten_text(text), expected)
               })

test_that(desc = "Replace multiple consecutive spaces by a single space: hello",
          code = {
               expect_equal(object   = shorten_text("Hello   world!"),
                            expected = "Hello world!")
           })

test_that(desc = "Replace multiple consecutive spaces by a single space: ants are best",
          code = {

               expect_equal(object   = shorten_text("Yes  maam  ants  are  best  sir."),
                            expected = "Yes maam ants are best sir.")
          })


test_that("Function does not abbreviate 5-character words", {
  text <- "Words like apple and water should remain."
  expected <- "Words like apple and water should remain."
  expect_equal(shorten_text(text), expected)
})

test_that(desc = "Abbreviate words longer than 5 chars (i.e. replace extra characters by a '.'): Lala",
          code = {
               expect_equal(object   = shorten_text("Lalalalalalalalala"),
                            expected = "Lalal.")
          })

test_that(desc = "Words longer than 5 characters are abbreviated",
          code = {
               text <- "Programming in R is interesting."
               expected <- "Progr. in R is inter.."
               expect_equal(shorten_text(text), expected)
          })


test_that(desc = "Abbreviate words longer than 5 chars (i.e. replace extra characters by a '.'): elephant",
          code = {
               expect_equal(object   = shorten_text("Superfragilistic elephant"),
                            expected = "Super. eleph.")
           })

test_that(desc = "Abbreviate words longer than 5 chars (i.e. replace extra characters by a '.'): expectation",
          code = {
               expect_equal(object   = shorten_text("Expectation, anticipation, gravity & hope."),
                            expected = "Expec., antic., gravi. & hope.")
           })


test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
               expect_equal(object   = shorten_text("We go hard or we go home We gon do this all very night long"),
                            expected = "We go hard or we go home We gon do this all night long")
           })

test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
              expect_equal(object   = shorten_text("Say hello to the world the big world"),
                           expected = "Say hello to world big world")
          })

test_that(desc = "Remove all of the following words: 'the', 'really', 'truly', 'very'.",
          code = {
              expect_equal(object   = shorten_text("The really big ants are truly cool and easy to look at."),
                           expected = "Big ants are cool and easy to look at.")
           })

test_that("Function abbreviates even if word has punctuation", {
  text <- "A functionality's details are specific."
  expected <- "A func.'s details are spec.."
  expect_equal(shorten_text(text), expected)
})

test_that("Specified words are removed", {
  text <- "The sky is really blue and truly blue."
  expected <- "Sky is blue and blue."
  expect_equal(shorten_text(text), expected)
})

test_that("Function does not remove words that contain 'the' as substring", {
  text <- "The theme of the meeting was thermal energy."
  expected <- "Theme of meeting was therm. energy."
  expect_equal(shorten_text(text), expected)
})

test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              expect_equal(object   = shorten_text("Long hair. Long life."),
                           expected = "Long hair.")
          })

test_that("Only the first sentence in every paragraph is kept", {
  text <- "This is the first sentence. This is the second.\n\nThis is the third. This is the fourth."
  expected <- "This is the first sentence.\n\nThis is the third."
  expect_equal(shorten_text(text), expected)
})

test_that("Function returns the shortened text", {
  text <- "The programming really class was truly very interesting. Students learned a lot."
  expected <- "Progr. class was inter.."
  expect_equal(shorten_text(text), expected)
})


test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              expect_equal(object   = shorten_text("I - confine myself to one special difficulty, which at first appeared to me insuperable, and actually fatal to my whole theory. I allude to the neuters or sterile females in insect-communities: for these neuters often differ widely in instinct and in structure from both the males and fertile females, and yet, from being sterile, they cannot propagate their kind. The subject well deserves to be discussed at great length, but I will here take only a single case, that of working or sterile ants."),
                           expected = "I - confi. mysel. to one speci. diffi., which at first appea. to me insup., and actua. fatal to my whole theor..")
          })

test_that(desc = "Keep only the first sentence in every paragraph.",
          code = {
              big_text <- paste("Les sangl longs des violo de l autom. Bless mon coeur dune lang monot. Tout suffo et bleme.",
                                "Quand sonne lheur, je me souvi des jours ancie. Et je pleur. Au vent mauve qui mempr. Deca dela. Parei a la feuil mort.",
                                sep = "\n")
              expected_shortened_text <- paste("Les sangl longs des violo de l autom.", "Quand sonne lheur, je me souvi des jours ancie.", sep = "\n")
              expect_equal(object   = shorten_text(big_text),
                           expected = expected_shortened_text)

          })


test_that("Function maintains paragraph structure with multiple spaces", {
  text <- "This is  a  test.    \n\nAnother   test with  spaces."
  expected <- "This is a test.\n\nAnother test with spaces."
  expect_equal(shorten_text(text), expected)
})


test_that("Function handles multiple paragraphs without additional sentences", {
  text <- "First sentence.\n\nSecond sentence.\n\nThird sentence."
  expected <- "First sentence.\n\nSecond sentence.\n\nThird sentence."
  expect_equal(shorten_text(text), expected)
})

test_that("Function maintains special characters in text", {
  text <- "Wow: !@#$ are same same."
  expected <- "Wow: !@#$ are same same."
  expect_equal(shorten_text(text), expected)
})
