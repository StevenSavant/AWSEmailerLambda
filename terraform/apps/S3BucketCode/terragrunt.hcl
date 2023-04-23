include {
    path = "${find_in_parent_folders()}"
}


terraform {
    source = "../../sources//S3Bucket"
}