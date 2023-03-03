CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission

echo 'Finished cloning'

if [ -f "student-submission/ListExamples.java" ]; then
    echo "it exits"
else
    echo "it does not exits"
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



# Clean up the cloned directory
cd ..
rm -rf student-submission

