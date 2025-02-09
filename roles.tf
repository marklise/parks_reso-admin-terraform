#CloudFront Roles

data "aws_iam_policy_document" "parks-admin-s3-policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bcgov-parks-reso-admin.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.parks-reso-admin-oai.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${aws_s3_bucket.bcgov-parks-reso-admin.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.parks-reso-admin-oai.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "parks-reso-admin" {
  bucket = "${aws_s3_bucket.bcgov-parks-reso-admin.id}"
  policy = "${data.aws_iam_policy_document.parks-admin-s3-policy.json}"
}
