#include <cstdio>
#include <iostream>

#include <windows.h>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

#define MAX_DIR_PATH 2048

using namespace std;
using namespace cv;

wstring getCurrentDirectory() {
    TCHAR buffer[MAX_DIR_PATH] = { 0 };

    GetCurrentDirectory(MAX_DIR_PATH, buffer);

    return std::wstring(buffer);
}

wstring getExecutablePath() {
    TCHAR buffer[MAX_DIR_PATH] = { 0 };

    GetModuleFileName(NULL, buffer, MAX_PATH);

    std::wstring::size_type pos = std::wstring(buffer).find_last_of(L"\\/");

    return std::wstring(buffer).substr(0, pos);
}

void colorReduce(cv::Mat image, int factor = 64) {
    cout << "salt()" << endl;

    if (image.type() == CV_8UC1) {
        /*
        cv::Mat_<uchar>::iterator it = image.begin<uchar>();
        cv::Mat_<uchar>::iterator itend = image.end<uchar>();

        for (; it != itend; ++it) {
            uchar element = *it;

            element = element / factor * factor + factor / 2;
        }
        */
    }
    else if (image.type() == CV_8UC3) {
        cv::Mat_<cv::Vec3b>::iterator it = image.begin<cv::Vec3b>();
        cv::Mat_<cv::Vec3b>::iterator itend = image.end<cv::Vec3b>();

        for (; it != itend; ++it) {
            (*it)[0] = (*it)[0] / factor * factor + factor / 2;
            (*it)[1] = (*it)[1] / factor * factor + factor / 2;
            (*it)[2] = (*it)[2] / factor * factor + factor / 2;
        }
    }
}

int main() {
    cout << "OpenCV color reduction" << endl;

    wcout << "Current directory: " << getCurrentDirectory() << endl;

    wcout << "Executable path: " << getExecutablePath() << endl;

    const int64 start = cv::getTickCount();

    cv::Mat image = imread("../resources/castle.bmp");

    colorReduce(image, 64);

    double duration = (cv::getTickCount() - start) / cv::getTickFrequency();

    cout << "Duration: " << duration << endl;

    cv::namedWindow("Image");

    cv::imshow("Image", image);

    cv::waitKey(0);

    return 0;
}