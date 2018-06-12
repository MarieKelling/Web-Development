using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;

namespace BISEC.Service
{
 
    public class FileSystemExplorerService
    {
            /// <summary>
            /// Gets the list of files in the directory Name passed
            /// </summary>
            /// <param name="directory">The Directory to get the files from</param>
            /// <returns>Returns the List of File info for this directory.
            /// Return null if an exception is raised</returns>
            public static IList<FileInfo> GetChildFiles(string directory)
            {
            try
                {
                return (from x in Directory.GetFiles(directory)
                        select new FileInfo(x)).ToList();
            }
                catch (Exception e){
                    Trace.WriteLine(e.Message);
                }

                return new List<FileInfo>();
            }
  
  
            /// <summary>
            /// Gets the list of directories 
            /// </summary>
            /// <param name="directory">The Directory to get the files from</param>
            /// <returns>Returns the List of directories info for this directory.
                /// Return null if an exception is raised</returns>
            public static IList<DirectoryInfo> GetChildDirectories(string directory)
                {
                    try
                {
                    return (from x in Directory.GetDirectories(directory)
                                select new DirectoryInfo(x)).ToList();
                    }
                    catch (Exception e)
                {
                    Trace.WriteLine(e.Message);
                }
 
                return new List<DirectoryInfo>();
            }
  
            /// <summary>
            /// Gets the root directories of the system
            /// </summary>
            /// <returns>Return the list of root directories</returns>
            public static IList<DriveInfo> GetRootDirectories()
            {
                return (from x in DriveInfo.GetDrives() select x).ToList();
            }

            public static DirectoryInfo GetParent(string directory)
            {
                return Directory.GetParent(directory);
            }

            public static bool DirExist(string directory)
            {
                if (!string.IsNullOrEmpty(directory))
                    return System.IO.Directory.Exists(directory);
                return false;
            }

            public static bool FileExist(string filepath)
            {
                if (!string.IsNullOrEmpty(filepath))
                    return System.IO.File.Exists(filepath);
                return false;
            }

            public static void DirectoryCopy(string srcDirectory, string destDirectory, bool copySubDirs = false)
            {
                DirectoryInfo dir = new DirectoryInfo(srcDirectory);
                DirectoryInfo[] dirs = dir.GetDirectories();

                // If the source directory does not exist, throw exception
                if (!dir.Exists)
                {
                    PrivateHelper.ShowErrorMessage("The source directory does not exist. Please contact IT Administrator.");
                }

                // If the destination directory does not exist, create it
                if (!Directory.Exists(destDirectory))
                {
                    Directory.CreateDirectory(destDirectory);
                }

                // Get the file contents of the directory to copy
                FileInfo[] files = dir.GetFiles();

                foreach (FileInfo file in files)
                {
                    // create the path to the new copy of the file.
                    string temppath = System.IO.Path.Combine(destDirectory, file.Name);

                    // copy the file if network is newer or create file if not exists
                    if (!File.Exists(temppath))
                        file.CopyTo(temppath, true);
                    else
                    {
                        if (File.GetLastWriteTime(temppath) < file.LastWriteTime)
                        {
                            file.CopyTo(temppath, true);
                        }
                    }
                }

                // if copySubDirs is true, copy the subdirectories
                if (copySubDirs)
                {
                    foreach (DirectoryInfo subdir in dirs)
                    {
                        // create the subdirectory
                        string temppath = System.IO.Path.Combine(destDirectory, subdir.Name);

                        // copy the subdirectory
                        DirectoryCopy(subdir.FullName, temppath, copySubDirs);
                    }
                }
            }
        }
    }

