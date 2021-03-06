require 'formula'

class Sdformat < Formula
  homepage 'http://gazebosim.org/sdf.html'
  url 'http://gazebosim.org/assets/distributions/sdformat-2.0.1.tar.bz2'
  sha1 '9738830c021378ed173a179a696d0e3f7489e1de'
  head 'https://bitbucket.org/osrf/sdformat', :branch => 'sdf_2.0', :using => :hg

  depends_on 'boost'
  depends_on 'cmake' => :build
  depends_on 'ros/deps/urdfdom'
  depends_on 'ros/deps/urdfdom_headers'
  depends_on 'doxygen'
  depends_on 'tinyxml'

  def install
    ENV.m64

    cmake_args = [
      "-DUSE_EXTERNAL_URDF:BOOL=True",
      "-DCMAKE_BUILD_TYPE='Release'",
      "-DCMAKE_INSTALL_PREFIX='#{prefix}'",
      "-Wno-dev"
    ]
    cmake_args << ".."

    mkdir "build" do
      system "cmake", *cmake_args
      system "make install"
    end
  end

  test do
    system "pkg-config --modversion sdformat"
  end
end
