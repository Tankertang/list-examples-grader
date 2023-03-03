CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission

echo 'Finished cloning'

if [ ! -rf $1 "student-submission/ListExamples.java" ]; then
    echo "Error: Could not find ListExamples.java in student submission"
    exit 1
fi

cp TestListExamples.java student-submission/
cp -r lib student-submission/

cd student-submission

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> javac-error.txt

if [ $? -ne 0 ]; then
    echo "Error: Compilation failed"
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples.java > test-output.txt
cat test-output.txt
if grep -q "FAILURES!!!" test-output.txt; then
    echo "Failed: 0/1 tests passed"
else
    echo "Passed: 1/1 tests passed"
fi

# Clean up the cloned directory
cd ..
rm -rf student-submission

